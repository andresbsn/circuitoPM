const { sequelize, Zone, ZoneTeam, ZoneMatch, ZoneStanding, Registration, Team, PlayerProfile, Category, TournamentCategory } = require('../models');

function shuffleArray(array, seed) {
  const arr = [...array];
  let currentIndex = arr.length;
  let temporaryValue, randomIndex;

  const random = () => {
    const x = Math.sin(seed++) * 10000;
    return x - Math.floor(x);
  };

  while (0 !== currentIndex) {
    randomIndex = Math.floor(random() * currentIndex);
    currentIndex -= 1;
    temporaryValue = arr[currentIndex];
    arr[currentIndex] = arr[randomIndex];
    arr[randomIndex] = temporaryValue;
  }

  return arr;
}

function generateRoundRobinFixture(teams) {
  const n = teams.length;
  const fixtures = [];

  if (n < 2) return fixtures;

  const teamsCopy = [...teams];

  // If odd number of teams, add a dummy team for bye
  if (n % 2 === 1) {
    teamsCopy.push(null); // 'null' represents a bye
  }

  const totalTeams = teamsCopy.length;
  const rounds = totalTeams - 1;
  const matchesPerRound = totalTeams / 2;

  for (let round = 0; round < rounds; round++) {
    const roundMatches = [];

    for (let match = 0; match < matchesPerRound; match++) {
      const home = teamsCopy[match];
      const away = teamsCopy[totalTeams - 1 - match];

      // Only add match if neither team is the dummy (bye)
      if (home !== null && away !== null) {
        roundMatches.push({ home, away });
      }
    }

    if (roundMatches.length > 0) {
      fixtures.push(roundMatches);
    }

    // Rotate teams: Keep the first team fixed, rotate the rest
    // [0, 1, 2, 3] -> [0, 3, 1, 2] -> [0, 2, 3, 1]
    const fixed = teamsCopy[0];
    const rotated = teamsCopy.slice(1);
    const last = rotated.pop();
    rotated.unshift(last);
    teamsCopy.splice(0, teamsCopy.length, fixed, ...rotated);
  }

  return fixtures;
}

async function generateZones(tournamentCategoryId, zoneSize, qualifiersPerZone, force = false) {
  const transaction = await sequelize.transaction();

  try {
    const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId);
    if (!tournamentCategory) {
      throw new Error('Categoría de torneo no encontrada');
    }

    const existingZones = await Zone.findAll({
      where: { tournament_category_id: tournamentCategoryId }
    });

    if (existingZones.length > 0) {
      const hasMatches = await ZoneMatch.count({
        where: { zone_id: existingZones.map(z => z.id), status: 'played' }
      });

      if (hasMatches > 0 && !force) {
        throw new Error('No se pueden regenerar las zonas porque ya hay partidos jugados. Use force=true para forzar la regeneración.');
      }

      if (!force) {
        await transaction.rollback();
        return { zones: existingZones, isNew: false };
      }

      await ZoneStanding.destroy({
        where: { zone_id: existingZones.map(z => z.id) },
        transaction
      });

      await ZoneMatch.destroy({
        where: { zone_id: existingZones.map(z => z.id) },
        transaction
      });

      await ZoneTeam.destroy({
        where: { zone_id: existingZones.map(z => z.id) },
        transaction
      });

      await Zone.destroy({
        where: { tournament_category_id: tournamentCategoryId },
        transaction
      });
    }

    const registrations = await Registration.findAll({
      where: {
        tournament_category_id: tournamentCategoryId,
        estado: ['inscripto', 'confirmado']
      },
      include: [
        {
          model: Team,
          as: 'team',
          include: [
            { model: PlayerProfile, as: 'player1' },
            { model: PlayerProfile, as: 'player2' }
          ]
        }
      ]
    });

    if (registrations.length < 2) {
      throw new Error('Se necesitan al menos 2 parejas inscritas para generar zonas');
    }

    const teams = registrations.map(r => r.team);
    const seed = tournamentCategoryId * 1000 + Date.now() % 1000;
    const shuffledTeams = shuffleArray(teams, seed);

    const numZones = Math.ceil(shuffledTeams.length / zoneSize);
    const zones = [];

    for (let i = 0; i < numZones; i++) {
      const zoneName = String.fromCharCode(65 + i);
      const zone = await Zone.create({
        tournament_category_id: tournamentCategoryId,
        name: `Zona ${zoneName}`,
        order_index: i
      }, { transaction });

      zones.push(zone);
    }

    for (let i = 0; i < shuffledTeams.length; i++) {
      const zoneIndex = i % numZones;
      await ZoneTeam.create({
        zone_id: zones[zoneIndex].id,
        team_id: shuffledTeams[i].id
      }, { transaction });
    }

    for (const zone of zones) {
      const zoneTeams = await ZoneTeam.findAll({
        where: { zone_id: zone.id },
        include: [{ model: Team, as: 'team' }],
        order: [['order_index', 'ASC']], // Important for deterministic pairing
        transaction
      });

      const teamsInZone = zoneTeams.map(zt => zt.team);

      // Special logic for 4 teams
      if (teamsInZone.length === 4) {
        // Round 1
        // Match 1: Pos 1 (index 0) vs Pos 4 (index 3)
        const match1 = await ZoneMatch.create({
          zone_id: zone.id,
          round_number: 1,
          match_number: 1,
          team_home_id: teamsInZone[0].id,
          team_away_id: teamsInZone[3].id,
          status: 'pending'
        }, { transaction });

        // Match 2: Pos 2 (index 1) vs Pos 3 (index 2)
        const match2 = await ZoneMatch.create({
          zone_id: zone.id,
          round_number: 1,
          match_number: 2,
          team_home_id: teamsInZone[1].id,
          team_away_id: teamsInZone[2].id,
          status: 'pending'
        }, { transaction });

        // Round 2
        // Match 3: Winner M1 vs Winner M2
        await ZoneMatch.create({
          zone_id: zone.id,
          round_number: 2,
          match_number: 3,
          team_home_id: null,
          team_away_id: null,
          parent_match_home_id: match1.id,
          parent_condition_home: 'winner',
          parent_match_away_id: match2.id,
          parent_condition_away: 'winner',
          status: 'pending'
        }, { transaction });

        // Match 4: Loser M1 vs Loser M2
        await ZoneMatch.create({
          zone_id: zone.id,
          round_number: 2,
          match_number: 4,
          team_home_id: null,
          team_away_id: null,
          parent_match_home_id: match1.id,
          parent_condition_home: 'loser',
          parent_match_away_id: match2.id,
          parent_condition_away: 'loser',
          status: 'pending'
        }, { transaction });

      } else {
        // Standard Round Robin for other sizes
        const fixtures = generateRoundRobinFixture(teamsInZone);

        let matchNumber = 1;
        for (let roundIndex = 0; roundIndex < fixtures.length; roundIndex++) {
          const round = fixtures[roundIndex];

          for (const match of round) {
            await ZoneMatch.create({
              zone_id: zone.id,
              round_number: roundIndex + 1,
              match_number: matchNumber++,
              team_home_id: match.home.id,
              team_away_id: match.away.id,
              status: 'pending'
            }, { transaction });
          }
        }
      }

      for (const team of teamsInZone) {
        await ZoneStanding.create({
          zone_id: zone.id,
          team_id: team.id,
          played: 0,
          wins: 0,
          losses: 0,
          points: 0,
          sets_for: 0,
          sets_against: 0,
          sets_diff: 0,
          games_for: 0,
          games_against: 0,
          games_diff: 0
        }, { transaction });
      }
    }

    await TournamentCategory.update(
      {
        zone_size: zoneSize,
        qualifiers_per_zone: qualifiersPerZone,
        estado: 'zonas_generadas'
      },
      { where: { id: tournamentCategoryId }, transaction }
    );

    await transaction.commit();

    return { zones, isNew: true };
  } catch (error) {
    await transaction.rollback();
    throw error;
  }
}

async function recalculateStandings(zoneId, tournamentCategoryId, transaction = null) {
  const t = transaction || await sequelize.transaction();
  const isLocalTransaction = !transaction;

  try {
    const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId, { transaction: t });
    const winPoints = tournamentCategory.win_points || 2;
    const lossPoints = tournamentCategory.loss_points || 0;

    const matches = await ZoneMatch.findAll({
      where: { zone_id: zoneId, status: 'played' },
      transaction: t
    });

    const standings = await ZoneStanding.findAll({
      where: { zone_id: zoneId },
      transaction: t
    });

    for (const standing of standings) {
      standing.played = 0;
      standing.wins = 0;
      standing.losses = 0;
      standing.points = 0;
      standing.sets_for = 0;
      standing.sets_against = 0;
      standing.sets_diff = 0;
      standing.games_for = 0;
      standing.games_against = 0;
      standing.games_diff = 0;
    }

    for (const match of matches) {
      const homeStanding = standings.find(s => s.team_id === match.team_home_id);
      const awayStanding = standings.find(s => s.team_id === match.team_away_id);

      if (!homeStanding || !awayStanding) continue;

      homeStanding.played++;
      awayStanding.played++;

      let homeSets = 0;
      let awaySets = 0;
      let homeGames = 0;
      let awayGames = 0;

      if (match.score_json && match.score_json.sets) {
        for (const set of match.score_json.sets) {
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
      }

      homeStanding.sets_for += homeSets;
      homeStanding.sets_against += awaySets;
      homeStanding.games_for += homeGames;
      homeStanding.games_against += awayGames;

      awayStanding.sets_for += awaySets;
      awayStanding.sets_against += homeSets;
      awayStanding.games_for += awayGames;
      awayStanding.games_against += homeGames;

      if (match.winner_team_id === match.team_home_id) {
        homeStanding.wins++;
        homeStanding.points += winPoints;
        awayStanding.losses++;
        awayStanding.points += lossPoints;
      } else {
        awayStanding.wins++;
        awayStanding.points += winPoints;
        homeStanding.losses++;
        homeStanding.points += lossPoints;
      }
    }

    for (const standing of standings) {
      standing.sets_diff = standing.sets_for - standing.sets_against;
      standing.games_diff = standing.games_for - standing.games_against;
      await standing.save({ transaction: t });
    }

    if (isLocalTransaction) await t.commit();
  } catch (error) {
    if (isLocalTransaction) await t.rollback();
    throw error;
  }
}

async function updateDependentMatches(matchId, transaction) {
  const t = transaction;

  try {
    const match = await ZoneMatch.findByPk(matchId, { transaction: t });
    if (!match || match.status !== 'played' || !match.winner_team_id) {
      return;
    }

    const loser_team_id = match.winner_team_id === match.team_home_id ? match.team_away_id : match.team_home_id;

    // Find dependent matches where this match is the parent for home or away
    const dependentMatches = await ZoneMatch.findAll({
      where: {
        [require('sequelize').Op.or]: [
          { parent_match_home_id: matchId },
          { parent_match_away_id: matchId }
        ]
      },
      transaction: t
    });

    for (const dependentMatch of dependentMatches) {
      let updated = false;

      // Update Home Team if dependent
      if (dependentMatch.parent_match_home_id === matchId) {
        if (dependentMatch.parent_condition_home === 'winner') {
          dependentMatch.team_home_id = match.winner_team_id;
        } else if (dependentMatch.parent_condition_home === 'loser') {
          dependentMatch.team_home_id = loser_team_id;
        }
        updated = true;
      }

      // Update Away Team if dependent
      if (dependentMatch.parent_match_away_id === matchId) {
        if (dependentMatch.parent_condition_away === 'winner') {
          dependentMatch.team_away_id = match.winner_team_id;
        } else if (dependentMatch.parent_condition_away === 'loser') {
          dependentMatch.team_away_id = loser_team_id;
        }
        updated = true;
      }

      if (updated) {
        await dependentMatch.save({ transaction: t });
      }
    }

  } catch (error) {
    console.error('Error updating dependent matches:', error);
    throw error;
  }
}

module.exports = {
  generateZones,
  recalculateStandings,
  updateDependentMatches
};
