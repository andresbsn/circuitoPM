const { sequelize, Bracket, Match, Zone, ZoneStanding, Team, PlayerProfile, Category, TournamentCategory } = require('../models');

function nextPowerOfTwo(n) {
  let power = 1;
  while (power < n) {
    power *= 2;
  }
  return power;
}

function getRoundName(totalRounds, currentRound) {
  const roundsFromEnd = totalRounds - currentRound;
  
  switch (roundsFromEnd) {
    case 0: return 'Final';
    case 1: return 'Semifinal';
    case 2: return 'Cuartos de Final';
    case 3: return 'Octavos de Final';
    case 4: return '16vos de Final';
    case 5: return '32vos de Final';
    default: return `Ronda ${currentRound}`;
  }
}

async function resolveHeadToHead(tiedTeams, zoneId, transaction) {
  if (tiedTeams.length !== 2) {
    return tiedTeams;
  }

  const { ZoneMatch } = require('../models');
  const teamIds = tiedTeams.map(t => t.team_id);
  
  const headToHeadMatch = await ZoneMatch.findOne({
    where: {
      zone_id: zoneId,
      status: 'played',
      team_home_id: teamIds,
      team_away_id: teamIds
    },
    transaction
  });

  if (!headToHeadMatch) {
    return tiedTeams;
  }

  const winnerFirst = tiedTeams.find(t => t.team_id === headToHeadMatch.winner_team_id);
  const loserSecond = tiedTeams.find(t => t.team_id !== headToHeadMatch.winner_team_id);
  
  return winnerFirst && loserSecond ? [winnerFirst, loserSecond] : tiedTeams;
}

async function generateBracketFromZones(tournamentCategoryId, force = false) {
  const transaction = await sequelize.transaction();

  try {
    const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId, { transaction });
    if (!tournamentCategory) {
      throw new Error('Categoría de torneo no encontrada');
    }

    const existingBracket = await Bracket.findOne({
      where: { tournament_category_id: tournamentCategoryId },
      transaction
    });

    if (existingBracket && !force) {
      const hasPlayedMatches = await Match.count({
        where: { bracket_id: existingBracket.id, status: 'played' },
        transaction
      });

      if (hasPlayedMatches > 0) {
        throw new Error('No se puede regenerar el bracket porque ya hay partidos jugados. Use force=true para forzar la regeneración.');
      }

      await transaction.rollback();
      return { bracket: existingBracket, isNew: false };
    }

    const zones = await Zone.findAll({
      where: { tournament_category_id: tournamentCategoryId },
      order: [['order_index', 'ASC']],
      transaction
    });

    if (zones.length === 0) {
      throw new Error('No hay zonas generadas para esta categoría');
    }

    const qualifiersPerZone = tournamentCategory.qualifiers_per_zone || 2;
    const qualifiedTeams = [];

    // Crear placeholders para todos los clasificados esperados
    for (let i = 0; i < zones.length; i++) {
      const zone = zones[i];
      
      // Intentar obtener los equipos clasificados si ya hay resultados
      let standings = await ZoneStanding.findAll({
        where: { zone_id: zone.id },
        include: [{ model: Team, as: 'team' }],
        order: [
          ['points', 'DESC'],
          ['sets_diff', 'DESC'],
          ['games_diff', 'DESC']
        ],
        transaction
      });

      const groupedByPoints = {};
      standings.forEach(s => {
        const key = `${s.points}_${s.sets_diff}_${s.games_diff}`;
        if (!groupedByPoints[key]) groupedByPoints[key] = [];
        groupedByPoints[key].push(s);
      });

      const resolvedStandings = [];
      for (const group of Object.values(groupedByPoints)) {
        if (group.length === 2) {
          const resolved = await resolveHeadToHead(group, zone.id, transaction);
          resolvedStandings.push(...resolved);
        } else {
          resolvedStandings.push(...group);
        }
      }

      // Crear placeholders para cada posición clasificatoria
      for (let pos = 1; pos <= qualifiersPerZone; pos++) {
        const standing = resolvedStandings[pos - 1];
        
        qualifiedTeams.push({
          team: standing?.team || null, // null si aún no hay resultados
          zone_id: zone.id,
          zone_name: zone.name,
          position: pos
        });
      }
    }

    const totalExpectedQualifiers = zones.length * qualifiersPerZone;
    if (totalExpectedQualifiers < 2) {
      throw new Error('Se necesitan al menos 2 equipos clasificados para generar playoffs');
    }

    if (existingBracket && force) {
      await Match.destroy({
        where: { bracket_id: existingBracket.id },
        transaction
      });

      await existingBracket.destroy({ transaction });
    }

    const bracket = await Bracket.create({
      tournament_category_id: tournamentCategoryId,
      status: 'published',
      generado_at: new Date()
    }, { transaction });

    const totalSlots = nextPowerOfTwo(totalExpectedQualifiers);
    const totalRounds = Math.log2(totalSlots);

    // Generar cruces según cantidad de zonas y clasificados
    const crossings = generateCrossings(zones.length, qualifiersPerZone);
    
    const seededTeams = [];
    for (let i = 0; i < totalSlots; i++) {
      if (i < crossings.length) {
        const crossing = crossings[i];
        const zone = zones[crossing.zoneIndex];
        const qualified = qualifiedTeams.find(q => q.zone_id === zone.id && q.position === crossing.position);
        
        seededTeams.push({
          team: qualified?.team || null,
          zone_id: zone.id,
          zone_name: zone.name,
          position: crossing.position
        });
      } else {
        seededTeams.push(null);
      }
    }

    const allMatches = [];
    let matchIdCounter = 1;

    for (let round = 1; round <= totalRounds; round++) {
      const matchesInRound = Math.pow(2, totalRounds - round);
      const roundName = getRoundName(totalRounds, round);

      for (let i = 0; i < matchesInRound; i++) {
        const match = {
          id: matchIdCounter++,
          bracket_id: bracket.id,
          round_number: round,
          round_name: roundName,
          match_number: i + 1,
          team_home_id: null,
          team_away_id: null,
          status: 'pending',
          next_match_id: null,
          next_match_slot: null
        };

        if (round === 1) {
          const homeIndex = i * 2;
          const awayIndex = i * 2 + 1;

          if (seededTeams[homeIndex]) {
            match.team_home_id = seededTeams[homeIndex].team?.id || null;
            match.home_source_zone_id = seededTeams[homeIndex].zone_id;
            match.home_source_position = seededTeams[homeIndex].position;
          }

          if (seededTeams[awayIndex]) {
            match.team_away_id = seededTeams[awayIndex].team?.id || null;
            match.away_source_zone_id = seededTeams[awayIndex].zone_id;
            match.away_source_position = seededTeams[awayIndex].position;
          }

          // Solo marcar como bye si hay un equipo definido y el otro slot está vacío (null en seededTeams)
          if (match.team_home_id && !seededTeams[awayIndex]) {
            match.status = 'bye';
            match.winner_team_id = match.team_home_id;
          } else if (match.team_away_id && !seededTeams[homeIndex]) {
            match.status = 'bye';
            match.winner_team_id = match.team_away_id;
          }
        }

        allMatches.push(match);
      }
    }

    for (let round = 1; round < totalRounds; round++) {
      const matchesInCurrentRound = Math.pow(2, totalRounds - round);
      const matchesInNextRound = Math.pow(2, totalRounds - round - 1);
      const currentRoundStartIndex = allMatches.findIndex(m => m.round_number === round);
      const nextRoundStartIndex = allMatches.findIndex(m => m.round_number === round + 1);

      for (let i = 0; i < matchesInCurrentRound; i++) {
        const currentMatch = allMatches[currentRoundStartIndex + i];
        const nextMatchIndex = Math.floor(i / 2);
        const nextMatch = allMatches[nextRoundStartIndex + nextMatchIndex];

        currentMatch.next_match_id = nextMatch.id;
        currentMatch.next_match_slot = (i % 2 === 0) ? 'home' : 'away';
      }
    }

    // Crear partidos sin next_match_id primero
    const createdMatches = [];
    for (const matchData of allMatches) {
      const { next_match_id, ...dataWithoutNext } = matchData;
      const created = await Match.create(dataWithoutNext, { transaction });
      createdMatches.push({ created, originalData: matchData });
    }

    // Actualizar next_match_id ahora que todos los partidos existen
    for (const { created, originalData } of createdMatches) {
      if (originalData.next_match_id) {
        created.next_match_id = originalData.next_match_id;
        created.next_match_slot = originalData.next_match_slot;
        await created.save({ transaction });
      }
    }

    // Procesar byes
    for (const match of allMatches) {
      if (match.status === 'bye') {
        await advanceWinnerToNextMatch(match.id, transaction);
      }
    }

    await TournamentCategory.update(
      { estado: 'playoffs_generados' },
      { where: { id: tournamentCategoryId }, transaction }
    );

    await transaction.commit();

    return { bracket, isNew: true };
  } catch (error) {
    await transaction.rollback();
    throw error;
  }
}

function generateCrossings(numZones, qualifiersPerZone) {
  const crossings = [];

  if (numZones === 2 && qualifiersPerZone === 2) {
    crossings.push({ zoneIndex: 0, position: 1 });
    crossings.push({ zoneIndex: 1, position: 2 });
    crossings.push({ zoneIndex: 1, position: 1 });
    crossings.push({ zoneIndex: 0, position: 2 });
  } else if (numZones === 4 && qualifiersPerZone === 2) {
    crossings.push({ zoneIndex: 0, position: 1 });
    crossings.push({ zoneIndex: 3, position: 2 });
    crossings.push({ zoneIndex: 1, position: 1 });
    crossings.push({ zoneIndex: 2, position: 2 });
    crossings.push({ zoneIndex: 2, position: 1 });
    crossings.push({ zoneIndex: 1, position: 2 });
    crossings.push({ zoneIndex: 3, position: 1 });
    crossings.push({ zoneIndex: 0, position: 2 });
  } else {
    for (let pos = 1; pos <= qualifiersPerZone; pos++) {
      for (let zone = 0; zone < numZones; zone++) {
        crossings.push({ zoneIndex: zone, position: pos });
      }
    }
  }

  return crossings;
}

async function advanceWinnerToNextMatch(matchId, transaction) {
  const match = await Match.findByPk(matchId, { transaction });
  
  if (!match.winner_team_id || !match.next_match_id) {
    return;
  }

  const nextMatch = await Match.findByPk(match.next_match_id, { transaction });
  
  if (match.next_match_slot === 'home') {
    nextMatch.team_home_id = match.winner_team_id;
  } else {
    nextMatch.team_away_id = match.winner_team_id;
  }

  if (nextMatch.team_home_id && !nextMatch.team_away_id) {
    nextMatch.status = 'bye';
    nextMatch.winner_team_id = nextMatch.team_home_id;
    await nextMatch.save({ transaction });
    await advanceWinnerToNextMatch(nextMatch.id, transaction);
  } else if (!nextMatch.team_home_id && nextMatch.team_away_id) {
    nextMatch.status = 'bye';
    nextMatch.winner_team_id = nextMatch.team_away_id;
    await nextMatch.save({ transaction });
    await advanceWinnerToNextMatch(nextMatch.id, transaction);
  } else {
    await nextMatch.save({ transaction });
  }
}

module.exports = {
  generateBracketFromZones,
  advanceWinnerToNextMatch
};
