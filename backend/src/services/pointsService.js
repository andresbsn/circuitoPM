const { sequelize, TournamentPoints, TournamentCategory, Match, Bracket, Team, PlayerProfile, Zone, ZoneTeam } = require('../models');

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

  // Buscar el último partido jugado por este equipo
  const lastMatch = await Match.findOne({
    where: {
      bracket_id: bracket.id,
      status: 'played',
      [sequelize.Op.or]: [
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

  // Agrupar por jugador y calcular puntos totales en esta categoría
  const playerPointsMap = {};

  tournamentPoints.forEach(tp => {
    const playerDni = tp.player_dni;
    
    if (!playerPointsMap[playerDni]) {
      playerPointsMap[playerDni] = {
        dni: tp.player.dni,
        nombre: tp.player.nombre,
        apellido: tp.player.apellido,
        categoria: tp.tournamentCategory.category.name,
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

    if (!pointsByCategory[categoryId]) {
      pointsByCategory[categoryId] = {
        categoryId: categoryId,
        categoryName: categoryName,
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

  // Convertir a array y calcular tournamentsPlayed
  const categoriesData = Object.values(pointsByCategory).map(cat => ({
    categoryId: cat.categoryId,
    categoryName: cat.categoryName,
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
      categoriaBase: player.categoriaBase?.name
    },
    categories: categoriesData,
    totalTournaments: player.tournamentPoints.length
  };
}

module.exports = {
  assignTournamentPoints,
  getPlayerRanking,
  getPlayerPoints,
  POINTS_TABLE
};
