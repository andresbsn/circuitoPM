const { sequelize, Zone, ZoneTeam, ZoneMatch } = require('../models');
const { recalculateStandings } = require('../services/zoneService');
const { updatePlayoffsAfterZoneResults } = require('../services/playoffUpdateService');

async function getFourTeamZones() {
  const zones = await Zone.findAll({
    include: [{ model: ZoneTeam, as: 'zoneTeams' }]
  });

  return zones.filter(zone => (zone.zoneTeams || []).length === 4);
}

async function recalculateFourTeamZones() {
  try {
    const zones = await getFourTeamZones();

    for (const zone of zones) {
      await recalculateStandings(zone.id, zone.tournament_category_id);

      const totalMatches = await ZoneMatch.count({
        where: { zone_id: zone.id }
      });
      const playedMatches = await ZoneMatch.count({
        where: { zone_id: zone.id, status: 'played' }
      });

      if (totalMatches > 0 && playedMatches === totalMatches) {
        await updatePlayoffsAfterZoneResults(zone.id);
      }

      console.log(`Zona ${zone.id}: standings recalculados (${playedMatches}/${totalMatches} partidos jugados).`);
    }

    console.log(`Proceso finalizado. Zonas procesadas: ${zones.length}.`);
  } catch (error) {
    console.error('Error recalculando zonas de 4 parejas:', error);
    process.exitCode = 1;
  } finally {
    await sequelize.close();
  }
}

recalculateFourTeamZones();
