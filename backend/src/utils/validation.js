const { PlayerProfile, Category, Team, Registration, TournamentCategory } = require('../models');

async function validateCategoryEligibility(playerDni, tournamentCategoryId) {
  const player = await PlayerProfile.findByPk(playerDni, {
    include: [{ model: Category, as: 'categoriaBase' }]
  });

  if (!player) {
    return { valid: false, error: 'Jugador no encontrado' };
  }

  const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId, {
    include: [{ model: Category, as: 'category' }]
  });

  if (!tournamentCategory) {
    return { valid: false, error: 'Categoría de torneo no encontrada' };
  }

  // Validar Género
  const categoryGender = tournamentCategory.category.gender;
  const playerGender = player.genero;

  if (categoryGender === 'caballeros' && playerGender !== 'M') {
    return { valid: false, error: `Esta categoría es de Caballeros, el jugador es Femenino` };
  }

  if (categoryGender === 'damas' && playerGender !== 'F') {
    return { valid: false, error: `Esta categoría es de Damas, el jugador es Masculino` };
  }

  const baseRank = player.categoriaBase.rank;
  const tournamentRank = tournamentCategory.category.rank;

  if (tournamentRank < baseRank - 1 || tournamentRank > baseRank) {
    return {
      valid: false,
      error: `El jugador solo puede jugar en su categoría base (${player.categoriaBase.name}) o una categoría superior (rank ${baseRank - 1})`
    };
  }

  return { valid: true };
}

async function validateTeamCategoryEligibility(teamId, tournamentCategoryId) {
  const team = await Team.findByPk(teamId, {
    include: [
      { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
      { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
    ]
  });

  if (!team) {
    return { valid: false, error: 'Pareja no encontrada' };
  }

  const validation1 = await validateCategoryEligibility(team.player1_dni, tournamentCategoryId);
  if (!validation1.valid) {
    return { valid: false, error: `Jugador 1 (${team.player1.nombre} ${team.player1.apellido}): ${validation1.error}` };
  }

  const validation2 = await validateCategoryEligibility(team.player2_dni, tournamentCategoryId);
  if (!validation2.valid) {
    return { valid: false, error: `Jugador 2 (${team.player2.nombre} ${team.player2.apellido}): ${validation2.error}` };
  }

  return { valid: true };
}

async function validateRegistration(teamId, tournamentCategoryId) {
  const team = await Team.findByPk(teamId);
  if (!team) {
    return { valid: false, error: 'Pareja no encontrada' };
  }

  if (team.estado !== 'activa') {
    return { valid: false, error: 'La pareja no está activa' };
  }

  const categoryValidation = await validateTeamCategoryEligibility(teamId, tournamentCategoryId);
  if (!categoryValidation.valid) {
    return categoryValidation;
  }

  const existingRegistration = await Registration.findOne({
    where: {
      tournament_category_id: tournamentCategoryId,
      team_id: teamId,
      estado: ['inscripto', 'confirmado']
    }
  });

  if (existingRegistration) {
    return { valid: false, error: 'La pareja ya está inscripta en esta categoría' };
  }

  const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId);
  if (!tournamentCategory.inscripcion_abierta) {
    return { valid: false, error: 'Las inscripciones están cerradas para esta categoría' };
  }

  if (tournamentCategory.cupo) {
    const registrationCount = await Registration.count({
      where: {
        tournament_category_id: tournamentCategoryId,
        estado: ['inscripto', 'confirmado']
      }
    });

    if (registrationCount >= tournamentCategory.cupo) {
      return { valid: false, error: 'No hay cupos disponibles para esta categoría' };
    }
  }

  return { valid: true };
}

function validateScoreFormat(scoreJson, matchFormat, superTiebreakPoints = 10) {
  if (!scoreJson || !scoreJson.sets || !Array.isArray(scoreJson.sets)) {
    return { valid: false, error: 'Formato de resultado inválido' };
  }

  const sets = scoreJson.sets;

  if (matchFormat === 'BEST_OF_3_SUPER_TB') {
    if (sets.length < 2 || sets.length > 3) {
      return { valid: false, error: 'Debe haber 2 o 3 sets para BEST_OF_3_SUPER_TB' };
    }

    let homeSets = 0;
    let awaySets = 0;

    for (let i = 0; i < sets.length; i++) {
      const set = sets[i];
      
      if (set.type === 'SUPER_TB') {
        if (i !== 2) {
          return { valid: false, error: 'El super tie-break solo puede ser el tercer set' };
        }
        
        const maxPoints = Math.max(set.home, set.away);
        const minPoints = Math.min(set.home, set.away);
        
        if (maxPoints < superTiebreakPoints) {
          return { valid: false, error: `El super tie-break debe llegar al menos a ${superTiebreakPoints} puntos` };
        }
        
        if (maxPoints - minPoints < 2) {
          return { valid: false, error: 'El super tie-break debe ganarse por diferencia de 2 puntos' };
        }
        
        if (set.home > set.away) homeSets++;
        else awaySets++;
      } else {
        if (!isValidSet(set.home, set.away)) {
          return { valid: false, error: `Set ${i + 1} tiene un resultado inválido` };
        }
        
        if (set.home > set.away) homeSets++;
        else awaySets++;
      }
    }

    if (sets.length === 2) {
      // Si hay 2 sets y uno ganó ambos (2-0), está OK
      if (homeSets === 2 || awaySets === 2) {
        return { valid: true };
      }
      // Si hay empate 1-1, debe haber un tercer set
      if (homeSets === awaySets) {
        return { valid: false, error: 'Si hay empate 1-1, debe jugarse el super tie-break (tercer set)' };
      }
    }

    if (sets.length === 3) {
      if (homeSets !== 2 && awaySets !== 2) {
        return { valid: false, error: 'Debe haber un ganador con 2 sets' };
      }
      const firstTwoSets = sets.slice(0, 2);
      let firstTwoHomeSets = 0;
      let firstTwoAwaySets = 0;
      for (const set of firstTwoSets) {
        if (set.home > set.away) firstTwoHomeSets++;
        else firstTwoAwaySets++;
      }
      if (firstTwoHomeSets === 2 || firstTwoAwaySets === 2) {
        return { valid: false, error: 'El partido ya estaba definido en 2 sets. No debería haber un tercer set.' };
      }
    }

  } else if (matchFormat === 'BEST_OF_3_FULL') {
    if (sets.length < 2 || sets.length > 3) {
      return { valid: false, error: 'Debe haber 2 o 3 sets para BEST_OF_3_FULL' };
    }

    let homeSets = 0;
    let awaySets = 0;

    for (let i = 0; i < sets.length; i++) {
      const set = sets[i];
      
      if (set.type === 'SUPER_TB') {
        return { valid: false, error: 'No se permite super tie-break en formato BEST_OF_3_FULL' };
      }
      
      if (!isValidSet(set.home, set.away)) {
        return { valid: false, error: `Set ${i + 1} tiene un resultado inválido` };
      }
      
      if (set.home > set.away) homeSets++;
      else awaySets++;
    }

    if (homeSets !== 2 && awaySets !== 2) {
      return { valid: false, error: 'Debe haber un ganador con 2 sets' };
    }
  }

  return { valid: true };
}

function isValidSet(home, away) {
  const max = Math.max(home, away);
  const min = Math.min(home, away);

  if (max === 7 && (min === 5 || min === 6)) return true;
  if (max === 6 && min <= 4) return true;

  return false;
}

function calculateMatchStats(scoreJson) {
  let homeSets = 0;
  let awaySets = 0;
  let homeGames = 0;
  let awayGames = 0;

  for (const set of scoreJson.sets) {
    if (set.home > set.away) {
      homeSets++;
    } else {
      awaySets++;
    }

    if (set.type !== 'SUPER_TB') {
      homeGames += set.home;
      awayGames += set.away;
    }
  }

  const winnerTeamId = homeSets > awaySets ? 'home' : 'away';

  return {
    homeSets,
    awaySets,
    homeGames,
    awayGames,
    winnerTeamId
  };
}

module.exports = {
  validateCategoryEligibility,
  validateTeamCategoryEligibility,
  validateRegistration,
  validateScoreFormat,
  calculateMatchStats
};
