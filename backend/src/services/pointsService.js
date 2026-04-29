const { Op } = require('sequelize');
const { sequelize, Tournament, TournamentPoints, TournamentCategory, Match, Bracket, Team, PlayerProfile, Zone, ZoneTeam, Category, PlayerCategoryAdjustment } = require('../models');

// Tabla de puntos según posición
const POINTS_TABLE = {
  'Campeón': 10,
  'Subcampeón': 8,
  'Semifinal': 6,
  'Cuartos de Final': 4,
  'Octavos de Final': 2,
  'Zona': 1
};

/**
 * Determina la posición final de un equipo en el torneo
 */
async function determineTeamPosition(teamId, tournamentCategoryId, transaction) {
  // Buscar bracket
  const bracket = await Bracket.findOne({
    where: { tournament_category_id: tournamentCategoryId },
    transaction
  });

  if (!bracket) {
    // Si no hay bracket, solo participó en zona
    return 'Zona';
  }

  const finalMatch = await Match.findOne({
    where: {
      bracket_id: bracket.id,
      round_name: 'Final',
      status: 'played'
    },
    transaction
  });

  if (finalMatch && (finalMatch.team_home_id === teamId || finalMatch.team_away_id === teamId)) {
    return finalMatch.winner_team_id === teamId ? 'Campeón' : 'Subcampeón';
  }

  // Buscar el último partido jugado por este equipo
  const lastMatch = await Match.findOne({
    where: {
      bracket_id: bracket.id,
      status: 'played',
      [Op.or]: [
        { team_home_id: teamId },
        { team_away_id: teamId }
      ]
    },
    order: [['round_number', 'DESC']],
    transaction
  });

  if (!lastMatch) {
    // Participó en playoffs pero no jugó ningún partido
    return 'Zona';
  }

  // Determinar si ganó o perdió el último partido
  const won = lastMatch.winner_team_id === teamId;

  if (won) {
    // Si ganó el último partido, verificar si es la final
    if (lastMatch.round_name === 'Final') {
      return 'Campeón';
    }
    // Si ganó pero no es la final, significa que avanzó (no debería pasar si es el último)
    return lastMatch.round_name;
  } else {
    // Perdió el partido, su posición es la ronda donde perdió
    return lastMatch.round_name;
  }
}

/**
 * Asigna puntos a todos los equipos de una categoría de torneo
 */
async function assignTournamentPoints(tournamentCategoryId) {
  const transaction = await sequelize.transaction();

  try {
    // Verificar que la categoría existe y obtener el torneo
    const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId, { 
      include: [{ model: Tournament, as: 'tournament' }],
      transaction 
    });
    if (!tournamentCategory) {
      throw new Error('Categoría de torneo no encontrada');
    }

    // Verificar si el torneo tiene doble puntaje
    const pointsMultiplier = tournamentCategory.tournament.double_points ? 2 : 1;

    // Verificar que no se hayan asignado puntos previamente
    const existingPoints = await TournamentPoints.count({
      where: { tournament_category_id: tournamentCategoryId },
      transaction
    });

    if (existingPoints > 0) {
      throw new Error('Los puntos ya fueron asignados para esta categoría de torneo');
    }

    // Obtener todos los equipos que participaron en zonas
    const zoneTeams = await ZoneTeam.findAll({
      include: [
        {
          model: Zone,
          as: 'zone',
          where: { tournament_category_id: tournamentCategoryId },
          required: true
        },
        {
          model: Team,
          as: 'team',
          include: [
            { model: PlayerProfile, as: 'player1' },
            { model: PlayerProfile, as: 'player2' }
          ]
        }
      ],
      transaction
    });

    if (zoneTeams.length === 0) {
      throw new Error('No hay equipos registrados en esta categoría');
    }

    const pointsToCreate = [];

    // Para cada equipo, determinar su posición final y asignar puntos
    for (const zoneTeam of zoneTeams) {
      const team = zoneTeam.team;
      const position = await determineTeamPosition(team.id, tournamentCategoryId, transaction);
      const basePoints = POINTS_TABLE[position] || 1; // Default 1 punto si no se encuentra
      const finalPoints = basePoints * pointsMultiplier; // Aplicar multiplicador

      // Asignar puntos a ambos jugadores
      pointsToCreate.push({
        tournament_category_id: tournamentCategoryId,
        player_dni: team.player1_dni,
        team_id: team.id,
        points: finalPoints,
        position: position,
        awarded_at: new Date()
      });

      pointsToCreate.push({
        tournament_category_id: tournamentCategoryId,
        player_dni: team.player2_dni,
        team_id: team.id,
        points: finalPoints,
        position: position,
        awarded_at: new Date()
      });
    }

    // Crear todos los registros de puntos
    await TournamentPoints.bulkCreate(pointsToCreate, { transaction });

    // Marcar el torneo como finalizado
    await TournamentCategory.update(
      { estado: 'finalizado' },
      { where: { id: tournamentCategoryId }, transaction }
    );

    await transaction.commit();

    return {
      success: true,
      pointsAssigned: pointsToCreate.length,
      teamsProcessed: zoneTeams.length
    };
  } catch (error) {
    await transaction.rollback();
    throw error;
  }
}

/**
 * Obtiene el ranking de jugadores por categoría de torneo
 * Los puntos son independientes por categoría
 */
async function getPlayerRanking(categoryId = null, limit = 100) {
  if (!categoryId) {
    throw new Error('Se debe especificar una categoría para ver el ranking');
  }

  // Obtener todos los puntos de torneos de esta categoría
  const tournamentPoints = await TournamentPoints.findAll({
    include: [
      {
        model: TournamentCategory,
        as: 'tournamentCategory',
        where: { category_id: categoryId },
        required: true,
        include: [
          { model: Tournament, as: 'tournament' },
          { model: Category, as: 'category' }
        ]
      },
      {
        model: PlayerProfile,
        as: 'player',
        required: true
      }
    ]
  });

  const categoryAdjustments = await PlayerCategoryAdjustment.findAll({
    where: { category_id: categoryId },
    include: [
      {
        model: PlayerProfile,
        as: 'player',
        required: true
      },
      {
        model: Category,
        as: 'category',
        required: true
      }
    ]
  });

  // Agrupar por jugador y calcular puntos totales en esta categoría
  const playerPointsMap = {};

  tournamentPoints.forEach(tp => {
    const playerDni = tp.player_dni;
    
    if (!playerPointsMap[playerDni]) {
      playerPointsMap[playerDni] = {
        dni: tp.player.dni,
        nombre: tp.player.nombre,
        apellido: tp.player.apellido,
        categoria: `${tp.tournamentCategory.category.name} (${tp.tournamentCategory.category.gender})`,
        categoryId: categoryId,
        totalPoints: 0,
        tournamentsPlayed: new Set(),
        pointsHistory: []
      };
    }

    playerPointsMap[playerDni].totalPoints += tp.points;
    playerPointsMap[playerDni].tournamentsPlayed.add(tp.tournament_category_id);
    playerPointsMap[playerDni].pointsHistory.push({
      tournament: tp.tournamentCategory.tournament.name,
      category: tp.tournamentCategory.category.name,
      points: tp.points,
      position: tp.position,
      date: tp.awarded_at,
      isDoublePoints: tp.tournamentCategory.tournament.double_points
    });
  });

  categoryAdjustments.forEach(adjustment => {
    const playerDni = adjustment.player_dni;

    if (!playerPointsMap[playerDni]) {
      playerPointsMap[playerDni] = {
        dni: adjustment.player.dni,
        nombre: adjustment.player.nombre,
        apellido: adjustment.player.apellido,
        categoria: `${adjustment.category.name} (${adjustment.category.gender})`,
        categoryId: categoryId,
        totalPoints: 0,
        tournamentsPlayed: new Set(),
        pointsHistory: []
      };
    }

    playerPointsMap[playerDni].totalPoints += adjustment.points;
  });

  // Convertir a array y calcular tournamentsPlayed
  const ranking = Object.values(playerPointsMap).map(player => ({
    ...player,
    tournamentsPlayed: player.tournamentsPlayed.size
  }));

  // Ordenar por puntos totales
  ranking.sort((a, b) => b.totalPoints - a.totalPoints);

  return ranking.slice(0, limit);
}

/**
 * Obtiene los puntos de un jugador específico, separados por categoría
 */
async function getPlayerPoints(playerDni) {
  const player = await PlayerProfile.findOne({
    where: { dni: playerDni },
    include: [
      {
        model: TournamentPoints,
        as: 'tournamentPoints',
        include: [
          {
            model: TournamentCategory,
            as: 'tournamentCategory',
            include: [
              { model: Tournament, as: 'tournament' },
              { model: Category, as: 'category' }
            ]
          }
        ]
      },
      {
        model: PlayerCategoryAdjustment,
        as: 'categoryAdjustments',
        include: [
          { model: Category, as: 'category' }
        ]
      },
      {
        model: Category,
        as: 'categoriaBase'
      }
    ]
  });

  if (!player) {
    throw new Error('Jugador no encontrado');
  }

  // Agrupar puntos por categoría
  const pointsByCategory = {};

  player.tournamentPoints.forEach(tp => {
    const categoryId = tp.tournamentCategory.category_id;
    const categoryName = tp.tournamentCategory.category.name;
    const categoryGender = tp.tournamentCategory.category.gender;

    if (!pointsByCategory[categoryId]) {
      pointsByCategory[categoryId] = {
        categoryId: categoryId,
        categoryName: categoryName,
        categoryGender: categoryGender,
        totalPoints: 0,
        tournamentsPlayed: new Set(),
        pointsHistory: []
      };
    }

    pointsByCategory[categoryId].totalPoints += tp.points;
    pointsByCategory[categoryId].tournamentsPlayed.add(tp.tournament_category_id);
    pointsByCategory[categoryId].pointsHistory.push({
      tournament: tp.tournamentCategory.tournament.name,
      points: tp.points,
      position: tp.position,
      date: tp.awarded_at,
      isDoublePoints: tp.tournamentCategory.tournament.double_points
    });
  });

  player.categoryAdjustments.forEach(adjustment => {
    const categoryId = adjustment.category_id;
    const categoryName = adjustment.category?.name || 'Sin categoría';
    const categoryGender = adjustment.category?.gender || null;

    if (!pointsByCategory[categoryId]) {
      pointsByCategory[categoryId] = {
        categoryId: categoryId,
        categoryName: categoryName,
        categoryGender: categoryGender,
        totalPoints: 0,
        tournamentsPlayed: new Set(),
        pointsHistory: []
      };
    }

    pointsByCategory[categoryId].totalPoints += adjustment.points;
  });

  // Convertir a array y calcular tournamentsPlayed
  const categoriesData = Object.values(pointsByCategory).map(cat => ({
    categoryId: cat.categoryId,
    categoryName: cat.categoryName,
    categoryGender: cat.categoryGender,
    totalPoints: cat.totalPoints,
    tournamentsPlayed: cat.tournamentsPlayed.size,
    pointsHistory: cat.pointsHistory
  }));

  // Ordenar por puntos totales descendente
  categoriesData.sort((a, b) => b.totalPoints - a.totalPoints);

  return {
    player: {
      dni: player.dni,
      nombre: player.nombre,
      apellido: player.apellido,
      genero: player.genero,
      categoriaBase: player.categoriaBase?.name,
      categoriaBaseGender: player.categoriaBase?.gender
    },
    categories: categoriesData,
    totalTournaments: player.tournamentPoints.length
  };
}

async function applyPromotionPoints({ playerDni, fromCategoryId, toCategoryId, transaction }) {
  const existingAdjustment = await PlayerCategoryAdjustment.findOne({
    where: {
      player_dni: playerDni,
      category_id: toCategoryId,
      source_category_id: fromCategoryId,
      reason: 'ascenso'
    },
    transaction
  });

  if (existingAdjustment) {
    throw new Error('El ascenso ya fue aplicado previamente');
  }

  // Sumar puntos de torneos en la categoría de origen
  const tournamentPoints = await TournamentPoints.sum('points', {
    where: { player_dni: playerDni },
    include: [
      {
        model: TournamentCategory,
        as: 'tournamentCategory',
        where: { category_id: fromCategoryId },
        required: true,
        attributes: []
      }
    ],
    transaction
  }) || 0;

  // Sumar ajustes previos en la categoría de origen (para que el ascenso sea acumulativo/en cascada)
  const adjustmentPoints = await PlayerCategoryAdjustment.sum('points', {
    where: {
      player_dni: playerDni,
      category_id: fromCategoryId
    },
    transaction
  }) || 0;

  const totalPoints = tournamentPoints + adjustmentPoints;

  // Obtener IDs de categorías de torneo de origen para eliminarlas
  const tournamentCategories = await TournamentCategory.findAll({
    where: { category_id: fromCategoryId },
    attributes: ['id'],
    transaction
  });

  const tournamentCategoryIds = tournamentCategories.map(category => category.id);

  // Eliminar puntos de la categoría anterior (se "pasan" a la nueva)
  if (tournamentCategoryIds.length > 0) {
    await TournamentPoints.destroy({
      where: {
        player_dni: playerDni,
        tournament_category_id: tournamentCategoryIds
      },
      transaction
    });
  }

  // Eliminar ajustes de la categoría anterior (se "pasan" a la nueva)
  await PlayerCategoryAdjustment.destroy({
    where: {
      player_dni: playerDni,
      category_id: fromCategoryId
    },
    transaction
  });

  // Calcular el 70%, redondeado
  const roundedPoints = Math.round(totalPoints * 0.7);

  if (roundedPoints > 0) {
    await PlayerCategoryAdjustment.create({
      player_dni: playerDni,
      category_id: toCategoryId,
      source_category_id: fromCategoryId,
      points: roundedPoints,
      reason: 'ascenso'
    }, { transaction });
  }

  return {
    movedPoints: totalPoints,
    newPoints: roundedPoints
  };
}

module.exports = {
  assignTournamentPoints,
  getPlayerRanking,
  getPlayerPoints,
  applyPromotionPoints,
  POINTS_TABLE
};
