const { ZoneMatch } = require('../models');

function buildOrderedStandings(standings, teamOrder) {
  const ordered = [];

  for (const teamId of teamOrder) {
    const standing = standings.find(s => s.team_id === teamId);
    if (!standing) {
      return null;
    }
    ordered.push(standing);
  }

  return ordered;
}

async function resolveFourTeamStandings(zoneId, standings, transaction) {
  if (!standings || standings.length !== 4) {
    return null;
  }

  const matches = await ZoneMatch.findAll({
    where: { zone_id: zoneId, round_number: 2 },
    transaction
  });

  if (matches.length < 2) {
    return null;
  }

  const finalMatch = matches.find(match => match.match_number === 3);
  const thirdPlaceMatch = matches.find(match => match.match_number === 4);

  if (!finalMatch || !thirdPlaceMatch) {
    return null;
  }

  if (
    finalMatch.status !== 'played' ||
    thirdPlaceMatch.status !== 'played' ||
    !finalMatch.winner_team_id ||
    !thirdPlaceMatch.winner_team_id
  ) {
    return null;
  }

  const finalLoserId = finalMatch.winner_team_id === finalMatch.team_home_id
    ? finalMatch.team_away_id
    : finalMatch.team_home_id;
  const thirdPlaceLoserId = thirdPlaceMatch.winner_team_id === thirdPlaceMatch.team_home_id
    ? thirdPlaceMatch.team_away_id
    : thirdPlaceMatch.team_home_id;

  const orderedStandings = buildOrderedStandings(standings, [
    finalMatch.winner_team_id,
    finalLoserId,
    thirdPlaceMatch.winner_team_id,
    thirdPlaceLoserId
  ]);

  return orderedStandings;
}

module.exports = {
  resolveFourTeamStandings
};
