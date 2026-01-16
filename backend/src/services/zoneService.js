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
  
  if (n % 2 === 1) {
    teamsCopy.push(null);
  }

  const totalTeams = teamsCopy.length;
  const rounds = totalTeams - 1;
  const matchesPerRound = totalTeams / 2;

  for (let round = 0; round < rounds; round++) {
    const roundMatches = [];
    
    for (let match = 0; match < matchesPerRound; match++) {
      const home = teamsCopy[match];
      const away = teamsCopy[totalTeams - 1 - match];
      
      if (home !== null && away !== null) {
        roundMatches.push({ home, away });
      }
    }
    
    fixtures.push(roundMatches);
    
    const fixed = teamsCopy[0];
    const rotated = teamsCopy.slice(1);
    rotated.push(rotated.shift());
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
        transaction
      });

      const teamsInZone = zoneTeams.map(zt => zt.team);
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

async function recalculateStandings(zoneId, tournamentCategoryId) {
  const transaction = await sequelize.transaction();

  try {
    const tournamentCategory = await TournamentCategory.findByPk(tournamentCategoryId);
    const winPoints = tournamentCategory.win_points || 2;
    const lossPoints = tournamentCategory.loss_points || 0;

    const matches = await ZoneMatch.findAll({
      where: { zone_id: zoneId, status: 'played' },
      transaction
    });

    const standings = await ZoneStanding.findAll({
      where: { zone_id: zoneId },
      transaction
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
      await standing.save({ transaction });
    }

    await transaction.commit();
  } catch (error) {
    await transaction.rollback();
    throw error;
  }
}

module.exports = {
  generateZones,
  recalculateStandings
};
