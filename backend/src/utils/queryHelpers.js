const { Team, PlayerProfile, Category, TournamentCategory, Tournament, Registration, Zone } = require('../models');

const includeTeamWithPlayers = () => ({
  model: Team,
  as: 'team',
  include: [
    { 
      model: PlayerProfile, 
      as: 'player1', 
      include: [{ model: Category, as: 'categoriaBase' }] 
    },
    { 
      model: PlayerProfile, 
      as: 'player2', 
      include: [{ model: Category, as: 'categoriaBase' }] 
    }
  ]
});

const includeTournamentCategory = () => ({
  model: TournamentCategory,
  as: 'tournamentCategory',
  include: [
    { model: Category, as: 'category' },
    { model: Tournament, as: 'tournament' }
  ]
});

const includeTournamentWithCategories = () => ({
  model: TournamentCategory,
  as: 'categories',
  include: [{ 
    model: Category, 
    as: 'category',
    attributes: ['id', 'name', 'rank', 'active']
  }]
});

const includeRegistrationFull = () => ({
  include: [
    includeTournamentCategory(),
    includeTeamWithPlayers()
  ]
});

const includeMatchTeams = () => [
  { 
    model: Team, 
    as: 'teamHome', 
    required: false,
    include: [
      { model: PlayerProfile, as: 'player1' }, 
      { model: PlayerProfile, as: 'player2' }
    ] 
  },
  { 
    model: Team, 
    as: 'teamAway', 
    required: false,
    include: [
      { model: PlayerProfile, as: 'player1' }, 
      { model: PlayerProfile, as: 'player2' }
    ] 
  },
  { model: Team, as: 'winner', required: false },
  { model: Zone, as: 'homeSourceZone', required: false },
  { model: Zone, as: 'awaySourceZone', required: false }
];

const includeZoneMatchTeams = () => [
  { 
    model: Team, 
    as: 'teamHome', 
    required: false,
    include: [
      { model: PlayerProfile, as: 'player1' }, 
      { model: PlayerProfile, as: 'player2' }
    ] 
  },
  { 
    model: Team, 
    as: 'teamAway', 
    required: false,
    include: [
      { model: PlayerProfile, as: 'player1' }, 
      { model: PlayerProfile, as: 'player2' }
    ] 
  },
  { model: Team, as: 'winner', required: false }
];

const getTeamWithPlayersById = async (teamId) => {
  return await Team.findByPk(teamId, {
    include: [
      { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
      { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
    ]
  });
};

const getRegistrationWithDetails = async (registrationId) => {
  return await Registration.findByPk(registrationId, includeRegistrationFull());
};

module.exports = {
  includeTeamWithPlayers,
  includeTournamentCategory,
  includeTournamentWithCategories,
  includeRegistrationFull,
  includeMatchTeams,
  includeZoneMatchTeams,
  getTeamWithPlayersById,
  getRegistrationWithDetails
};
