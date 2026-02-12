const sequelize = require('../config/database');
const User = require('./User');
const Category = require('./Category');
const PlayerProfile = require('./PlayerProfile');
const Team = require('./Team');
const Tournament = require('./Tournament');
const TournamentCategory = require('./TournamentCategory');
const Registration = require('./Registration');
const Zone = require('./Zone');
const ZoneTeam = require('./ZoneTeam');
const ZoneMatch = require('./ZoneMatch');
const ZoneStanding = require('./ZoneStanding');
const Bracket = require('./Bracket');
const Match = require('./Match');
const Venue = require('./Venue');
const TournamentPoints = require('./TournamentPoints');
const Locality = require('./Locality');

User.hasOne(PlayerProfile, { foreignKey: 'dni', sourceKey: 'dni', as: 'playerProfile' });
PlayerProfile.belongsTo(User, { foreignKey: 'dni', targetKey: 'dni', as: 'user' });

PlayerProfile.belongsTo(Category, { foreignKey: 'categoria_base_id', as: 'categoriaBase' });
Category.hasMany(PlayerProfile, { foreignKey: 'categoria_base_id', as: 'players' });

PlayerProfile.belongsTo(Locality, { foreignKey: 'locality_id', as: 'locality' });
Locality.hasMany(PlayerProfile, { foreignKey: 'locality_id', as: 'players' });

Team.belongsTo(PlayerProfile, { foreignKey: 'player1_dni', targetKey: 'dni', as: 'player1' });
Team.belongsTo(PlayerProfile, { foreignKey: 'player2_dni', targetKey: 'dni', as: 'player2' });

Tournament.hasMany(TournamentCategory, { foreignKey: 'tournament_id', as: 'categories' });
TournamentCategory.belongsTo(Tournament, { foreignKey: 'tournament_id', as: 'tournament' });

TournamentCategory.belongsTo(Category, { foreignKey: 'category_id', as: 'category' });
Category.hasMany(TournamentCategory, { foreignKey: 'category_id', as: 'tournamentCategories' });

Registration.belongsTo(TournamentCategory, { foreignKey: 'tournament_category_id', as: 'tournamentCategory' });
Registration.belongsTo(Team, { foreignKey: 'team_id', as: 'team' });
TournamentCategory.hasMany(Registration, { foreignKey: 'tournament_category_id', as: 'registrations' });
Team.hasMany(Registration, { foreignKey: 'team_id', as: 'registrations' });

Zone.belongsTo(TournamentCategory, { foreignKey: 'tournament_category_id', as: 'tournamentCategory' });
TournamentCategory.hasMany(Zone, { foreignKey: 'tournament_category_id', as: 'zones' });

ZoneTeam.belongsTo(Zone, { foreignKey: 'zone_id', as: 'zone' });
ZoneTeam.belongsTo(Team, { foreignKey: 'team_id', as: 'team' });
Zone.hasMany(ZoneTeam, { foreignKey: 'zone_id', as: 'zoneTeams' });

ZoneMatch.belongsTo(Zone, { foreignKey: 'zone_id', as: 'zone' });
ZoneMatch.belongsTo(Team, { foreignKey: 'team_home_id', as: 'teamHome' });
ZoneMatch.belongsTo(Team, { foreignKey: 'team_away_id', as: 'teamAway' });
ZoneMatch.belongsTo(Team, { foreignKey: 'winner_team_id', as: 'winner' });
Zone.hasMany(ZoneMatch, { foreignKey: 'zone_id', as: 'matches' });

ZoneStanding.belongsTo(Zone, { foreignKey: 'zone_id', as: 'zone' });
ZoneStanding.belongsTo(Team, { foreignKey: 'team_id', as: 'team' });
Zone.hasMany(ZoneStanding, { foreignKey: 'zone_id', as: 'standings' });

Bracket.belongsTo(TournamentCategory, { foreignKey: 'tournament_category_id', as: 'tournamentCategory' });
TournamentCategory.hasOne(Bracket, { foreignKey: 'tournament_category_id', as: 'bracket' });

Match.belongsTo(Bracket, { foreignKey: 'bracket_id', as: 'bracket' });
Match.belongsTo(Team, { foreignKey: 'team_home_id', as: 'teamHome' });
Match.belongsTo(Team, { foreignKey: 'team_away_id', as: 'teamAway' });
Match.belongsTo(Team, { foreignKey: 'winner_team_id', as: 'winner' });
Match.belongsTo(Match, { foreignKey: 'next_match_id', as: 'nextMatch' });
Match.belongsTo(Zone, { foreignKey: 'home_source_zone_id', as: 'homeSourceZone' });
Match.belongsTo(Zone, { foreignKey: 'away_source_zone_id', as: 'awaySourceZone' });
Bracket.hasMany(Match, { foreignKey: 'bracket_id', as: 'matches' });

TournamentPoints.belongsTo(TournamentCategory, { foreignKey: 'tournament_category_id', as: 'tournamentCategory' });
TournamentPoints.belongsTo(PlayerProfile, { foreignKey: 'player_dni', targetKey: 'dni', as: 'player' });
TournamentPoints.belongsTo(Team, { foreignKey: 'team_id', as: 'team' });
TournamentCategory.hasMany(TournamentPoints, { foreignKey: 'tournament_category_id', as: 'points' });
PlayerProfile.hasMany(TournamentPoints, { foreignKey: 'player_dni', sourceKey: 'dni', as: 'tournamentPoints' });

module.exports = {
  sequelize,
  User,
  Category,
  PlayerProfile,
  Team,
  Tournament,
  TournamentCategory,
  Registration,
  Zone,
  ZoneTeam,
  ZoneMatch,
  ZoneStanding,
  Bracket,
  Match,
  Venue,
  TournamentPoints
};
