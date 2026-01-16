const { sequelize, Match, Zone, ZoneStanding, TournamentCategory, Bracket } = require('../models');

async function updatePlayoffsAfterZoneResults(zoneId, transaction) {
  try {
    // Obtener la zona y su categoría de torneo
    const zone = await Zone.findByPk(zoneId, { 
      include: [{ model: TournamentCategory, as: 'tournamentCategory' }],
      transaction 
    });
    
    if (!zone) {
      return;
    }

    const tournamentCategoryId = zone.tournament_category_id;

    // Verificar si existen playoffs generados
    const bracket = await Bracket.findOne({
      where: { tournament_category_id: tournamentCategoryId },
      transaction
    });

    if (!bracket) {
      return; // No hay playoffs generados aún
    }

    // Obtener los standings actuales de la zona
    const standings = await ZoneStanding.findAll({
      where: { zone_id: zoneId },
      order: [
        ['points', 'DESC'],
        ['sets_diff', 'DESC'],
        ['games_diff', 'DESC']
      ],
      transaction
    });

    if (standings.length === 0) {
      return;
    }

    // Obtener partidos de playoffs que referencian esta zona
    const playoffMatches = await Match.findAll({
      where: {
        bracket_id: bracket.id,
        round_number: 1, // Solo primera ronda
        [sequelize.Op.or]: [
          { home_source_zone_id: zoneId },
          { away_source_zone_id: zoneId }
        ]
      },
      transaction
    });

    // Actualizar cada partido con los equipos clasificados
    for (const match of playoffMatches) {
      let updated = false;

      // Actualizar equipo local si corresponde a esta zona
      if (match.home_source_zone_id === zoneId && match.home_source_position) {
        const standing = standings[match.home_source_position - 1];
        if (standing && standing.team_id !== match.team_home_id) {
          match.team_home_id = standing.team_id;
          updated = true;
        }
      }

      // Actualizar equipo visitante si corresponde a esta zona
      if (match.away_source_zone_id === zoneId && match.away_source_position) {
        const standing = standings[match.away_source_position - 1];
        if (standing && standing.team_id !== match.team_away_id) {
          match.team_away_id = standing.team_id;
          updated = true;
        }
      }

      if (updated) {
        await match.save({ transaction });
      }
    }

    return true;
  } catch (error) {
    console.error('Error updating playoffs after zone results:', error);
    throw error;
  }
}

module.exports = {
  updatePlayoffsAfterZoneResults
};
