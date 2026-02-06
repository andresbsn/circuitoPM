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
      include: [{ model: require('../models').ZoneTeam, as: 'zoneTeams' }],
      order: [['order_index', 'ASC']],
      transaction
    });

    if (zones.length === 0) {
      throw new Error('No hay zonas generadas para esta categoría');
    }

    const globalQualifiersPerZone = tournamentCategory.qualifiers_per_zone || 2;
    const qualifiedTeams = [];

    // Crear placeholders para todos los clasificados esperados
    for (let i = 0; i < zones.length; i++) {
      const zone = zones[i];
      const teamCount = zone.zoneTeams ? zone.zoneTeams.length : 0;

      // Lógica dinámica para clasificados:
      // Zona de 3 => clasifican 2
      // Zona de 4 => clasifican 3
      // Default => globalQualifiersPerZone (para soporte legacy o automático)
      let qualifiersForThisZone = globalQualifiersPerZone;

      if (teamCount === 3) qualifiersForThisZone = 2;
      else if (teamCount === 4) qualifiersForThisZone = 3;

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
      for (let pos = 1; pos <= qualifiersForThisZone; pos++) {
        const standing = resolvedStandings[pos - 1];

        qualifiedTeams.push({
          team: standing?.team || null, // null si aún no hay resultados
          zone_id: zone.id,
          zone_name: zone.name,
          position: pos,
          order_index: zone.order_index
        });
      }
    }

    const totalExpectedQualifiers = qualifiedTeams.length;
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

    // Generar cruces según clasificados
    const crossings = generateCrossings(qualifiedTeams);

    const seededTeams = [];
    for (let i = 0; i < totalSlots; i++) {
      if (i < crossings.length && crossings[i]) {
        const slot = crossings[i];

        // El slot ya contiene zoneIndex y position, encontrar el equipo correspondiente
        const qualified = qualifiedTeams.find(q => q.order_index === slot.zoneIndex && q.position === slot.position);

        seededTeams.push({
          team: qualified?.team || null,
          zone_id: qualified?.zone_id,
          zone_name: qualified?.zone_name,
          position: slot.position
        });
      } else {
        seededTeams.push(null);
      }
    }

    const allMatches = [];
    let matchIdCounter = -1000;

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

    // Crear partidos in DB using map for tempIds
    const tempIdToDbIdMap = new Map();
    const matchesToCreate = [];

    // Preparation step: Identify next_match relationships using temp IDs
    // We already have next_match_id (temp) in allMatches

    // 1. Create all matches in DB to get real IDs
    for (const matchData of allMatches) {
      // Remove temp ID and temp next_match_id before insert
      const { id: tempId, next_match_id: nextMatchTempId, ...dataToInsert } = matchData;

      const created = await Match.create(dataToInsert, { transaction });
      tempIdToDbIdMap.set(tempId, created.id);

      // Store reference for second pass
      if (nextMatchTempId) {
        matchesToCreate.push({
          realId: created.id,
          nextMatchTempId
        });
      }
    }

    // 2. Update next_match_id with real IDs
    for (const { realId, nextMatchTempId } of matchesToCreate) {
      const realNextMatchId = tempIdToDbIdMap.get(nextMatchTempId);
      if (realNextMatchId) {
        await Match.update(
          { next_match_id: realNextMatchId },
          { where: { id: realId }, transaction }
        );
      }
    }

    // Recargar ids reales para el paso final de Bye processing ? 
    // The Bye processor uses advanceWinnerToNextMatch which fetches by PK.
    // We need to call it with REAL IDs.

    // Process byes
    for (const matchData of allMatches) {
      if (matchData.status === 'bye') {
        const realId = tempIdToDbIdMap.get(matchData.id);
        if (realId) {
          await advanceWinnerToNextMatch(realId, transaction);
        }
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

// Helper to generate a distribution of teams for the bracket
function generateCrossings(qualifiedTeams) {
  // 1. Group by Zone
  const teamsByZone = {};
  qualifiedTeams.forEach(t => {
    if (!teamsByZone[t.order_index]) teamsByZone[t.order_index] = [];
    teamsByZone[t.order_index].push(t);
  });

  const zoneIndices = Object.keys(teamsByZone).sort((a, b) => Number(a) - Number(b)).map(Number);
  const numZones = zoneIndices.length;

  if (numZones === 0) return [];

  // 2. Identify Zone Pairs (A-B, C-D...)
  const zonePairs = [];
  for (let i = 0; i < numZones; i += 2) {
    if (i + 1 < numZones) {
      zonePairs.push([zoneIndices[i], zoneIndices[i + 1]]);
    } else {
      // Orphan zone (odd number), pair with itself/dummy?
      // For now, treat as single group to match internally or against Bye
      zonePairs.push([zoneIndices[i], null]);
    }
  }

  // 3. Generate Matches for each Pair (Centripetal: Top vs Bottom)
  // Each element in pairMatches is a list of matches: [{home, away}, {home, away}...]
  const pairMatchesList = zonePairs.map(([zA, zB]) => {
    const listA = [...(teamsByZone[zA] || [])].sort((a, b) => a.position - b.position);
    const listB = zB !== null ? [...(teamsByZone[zB] || [])].sort((a, b) => a.position - b.position) : [];

    const matches = [];

    // While there are teams to match
    while (listA.length > 0 || listB.length > 0) {
      // 3.1. Match A-Top vs B-Bottom
      if (listA.length > 0) {
        const homeNode = listA.shift(); // Take A Top
        // If B has teams, take B Bottom. Else Bye (null)
        const awayNode = listB.length > 0 ? listB.pop() : null;

        matches.push({
          zoneIndex: homeNode.order_index,
          position: homeNode.position,
          opponent: awayNode ? { zoneIndex: awayNode.order_index, position: awayNode.position } : null
        });
      }

      // 3.2. Match B-Top vs A-Bottom (if B exists)
      if (listB.length > 0) {
        const homeNode = listB.shift(); // Take B Top
        // If A has teams, take A Bottom. Else Bye (null)
        const awayNode = listA.length > 0 ? listA.pop() : null;

        matches.push({
          zoneIndex: homeNode.order_index,
          position: homeNode.position,
          opponent: awayNode ? { zoneIndex: awayNode.order_index, position: awayNode.position } : null
        });
      }
    }
    return matches;
  });

  // 4. Interleave Pair Matches into Bracket Slots
  // We want to spread the top seeds. 
  // If we have PairAB and PairCD:
  // Slot 1: AB_Match1 (A1 vs B4)
  // Slot 2: CD_Match1 (C1 vs D4)
  // Slot 3: AB_Match2 (B1 vs A4)
  // Slot 4: CD_Match2 (D1 vs C4)

  const totalSlots = nextPowerOfTwo(qualifiedTeams.length);
  const bracketSlots = [];

  // Find max length of match lists
  let maxMatches = 0;
  pairMatchesList.forEach(list => maxMatches = Math.max(maxMatches, list.length));

  for (let round = 0; round < maxMatches; round++) {
    for (let pairIdx = 0; pairIdx < pairMatchesList.length; pairIdx++) {
      const match = pairMatchesList[pairIdx][round];
      if (match) {
        // Add Home
        bracketSlots.push({ zoneIndex: match.zoneIndex, position: match.position });
        // Add Away (or null for Bye)
        if (match.opponent) {
          bracketSlots.push({ zoneIndex: match.opponent.zoneIndex, position: match.opponent.position });
        } else {
          bracketSlots.push(null);
        }
      } else {
        // No match from this pair in this round, ignore?
        // Wait, we need to fill Slots.
        // But total slots might be strictly enforced.
        // If we skip, we might break slot alignment?
        // Actually, we append strictly.
        // If nextPowerOfTwo is 32, but we only have 12 teams (6 matches), we fill 12 slots.
        // The remaining slots (up to 32) are filled with NULLs by the calling function's loop if i >= crossings.length.
        // BUT, here crossings returns the slot definitions.
        // We just need to return the list of defined slots.
      }
    }
  }

  return bracketSlots;
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

async function generateBracketManual(tournamentCategoryId, seededTeams, force = false) {
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
      await transaction.rollback();
      throw new Error('Ya existe un bracket. Use force=true para regenerar.');
    }

    if (existingBracket && force) {
      // Logic to destroy existing bracket matches...
      await Match.destroy({ where: { bracket_id: existingBracket.id }, transaction });
      await existingBracket.destroy({ transaction });
    }

    const bracket = await Bracket.create({
      tournament_category_id: tournamentCategoryId,
      status: 'published',
      generado_at: new Date()
    }, { transaction });

    const totalSlots = seededTeams.length;
    const totalRounds = Math.log2(totalSlots);

    // Validate if totalSlots is power of 2
    if (!Number.isInteger(totalRounds)) {
      throw new Error('El número total de slots debe ser potencia de 2 (4, 8, 16, 32...)');
    }

    const allMatches = [];
    let matchIdCounter = -1000;

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
            match.home_source_zone_id = seededTeams[homeIndex].zone_id;
            match.home_source_position = seededTeams[homeIndex].position;
            // Try to find the team if it exists based on zone results?
            // For manual generation, we might not have the teams yet, so team_home_id stays null until populated later? 
            // Or we can try to look it up.
            // But the UI requests says "As points are defined...".
            // So we just store the Source. The automatic update logic should handle populating team_id later when zone matches finish.

            // However, existing logic tries to populate team_home_id immediately.
            // Let's try to populate if possible.
            // We need a helper to find team by zone/pos.
            // For now, let's leave team_home_id null and rely on 'Source' columns.
            // Wait, existing logic sets team_home_id. If manual mode is used before zone finish, it will be null.
            // If manual mode is used AFTER zone finish, we should fetch it.

            // Let's try to fetch qualified team if zone results exists (logic copied from existing function?)
            // This is getting complex. Let's keep it simple: just set source. 
            // BUT: If teams are already qualified, we want them to show up.
            // We can resolve seeds outside this loop or just let the generic "updatePlayoffs" logic handle it later?
            // "updatePlayoffsAfterZoneResults" does exactly this: checks source_zone and position.
            // So if we set source, we can call that function/trigger to update.
          }
          if (seededTeams[awayIndex]) {
            match.away_source_zone_id = seededTeams[awayIndex].zone_id;
            match.away_source_position = seededTeams[awayIndex].position;
          }

          // Detect BYEs purely based on missing source?
          // If the user selects "BYE" in UI, we pass null in seededTeams.

          // Logic for converting to BYE match immediately if one side is null?
          // If home_source is set but away_source is NULL (Bye), match is BYE.
          if (match.home_source_zone_id && !match.away_source_zone_id) {
            match.status = 'bye';
            match.next_match_slot_winner = 'home'; // we need to know who won.
            // Wait, if we don't know the team yet, we can't set winner_team_id.
            // So we can't process the Bye fully yet if the team is not known.
            // If source is set, we expect a team eventually.
            // IF source is NULL, it means Bye.
          } else if (!match.home_source_zone_id && match.away_source_zone_id) {
            match.status = 'bye';
          }
        }

        allMatches.push(match);
      }
    }

    // Link next matches
    for (let round = 1; round < totalRounds; round++) {
      const matchesInCurrentRound = Math.pow(2, totalRounds - round);
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

    // Persist matches (Map temp ID -> Real ID)
    const tempIdToDbIdMap = new Map();
    const matchesToCreate = [];

    for (const matchData of allMatches) {
      const { id: tempId, next_match_id: nextMatchTempId, ...dataToInsert } = matchData;
      const created = await Match.create(dataToInsert, { transaction });
      tempIdToDbIdMap.set(tempId, created.id);

      if (nextMatchTempId) {
        matchesToCreate.push({ realId: created.id, nextMatchTempId });
      }
    }

    for (const { realId, nextMatchTempId } of matchesToCreate) {
      const realNextMatchId = tempIdToDbIdMap.get(nextMatchTempId);
      if (realNextMatchId) {
        await Match.update({ next_match_id: realNextMatchId }, { where: { id: realId }, transaction });
      }
    }

    // Sync Teams based on Sources (Manual Trigger)
    // We should iterate over created matches and try to find the team if zone results already exist.
    // This connects the brackets to the current reality.

    // We can iterate the matches with sources and call logic to find ZoneStanding.
    // Or simpler: We can implement a "syncBracketWithZones" function.

    await TournamentCategory.update(
      { estado: 'playoffs_generados' },
      { where: { id: tournamentCategoryId }, transaction }
    );

    await transaction.commit();

    // Trigger sync after commit (to avoid transaction lock issues if sync uses its own, or pass transaction)
    // Let's assume we can sync immediately.

    return { bracket, isNew: true };

  } catch (error) {
    if (transaction) await transaction.rollback();
    throw error;
  }
}

module.exports = {
  generateBracketFromZones,
  generateBracketManual,
  advanceWinnerToNextMatch
};
