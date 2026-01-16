const { Zone, ZoneTeam, ZoneMatch, ZoneStanding, Team, PlayerProfile, Category, Bracket, Match, TournamentCategory } = require('../models');
const { sendSuccess, sendError, sendValidationError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');
const { includeMatchTeams, includeZoneMatchTeams } = require('../utils/queryHelpers');

exports.getZones = async (req, res) => {
  try {
    const { tournament_category_id } = req.query;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const zones = await Zone.findAll({
      where: { tournament_category_id },
      include: [
        {
          model: ZoneTeam,
          as: 'zoneTeams',
          include: [
            {
              model: Team,
              as: 'team',
              include: [
                { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
                { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
              ]
            }
          ]
        }
      ],
      order: [['order_index', 'ASC']]
    });

    return sendSuccess(res, zones);
  } catch (error) {
    console.error('Get zones error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener zonas',
      details: error.message
    });
  }
};

exports.getStandings = async (req, res) => {
  try {
    const { tournament_category_id } = req.query;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const zones = await Zone.findAll({
      where: { tournament_category_id },
      include: [
        {
          model: ZoneStanding,
          as: 'standings',
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
        }
      ],
      order: [
        ['order_index', 'ASC'],
        [{ model: ZoneStanding, as: 'standings' }, 'points', 'DESC'],
        [{ model: ZoneStanding, as: 'standings' }, 'sets_diff', 'DESC'],
        [{ model: ZoneStanding, as: 'standings' }, 'games_diff', 'DESC']
      ]
    });

    return sendSuccess(res, zones);
  } catch (error) {
    console.error('Get standings error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener tabla de posiciones',
      details: error.message
    });
  }
};

exports.getZoneMatches = async (req, res) => {
  try {
    const { tournament_category_id } = req.query;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const zones = await Zone.findAll({
      where: { tournament_category_id }
    });

    const zoneIds = zones.map(z => z.id);

    const matches = await ZoneMatch.findAll({
      where: { zone_id: zoneIds },
      include: [
        { model: Zone, as: 'zone' },
        ...includeZoneMatchTeams()
      ],
      order: [['zone_id', 'ASC'], ['round_number', 'ASC'], ['match_number', 'ASC']]
    });

    return sendSuccess(res, matches);
  } catch (error) {
    console.error('Get zone matches error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener partidos',
      details: error.message
    });
  }
};

exports.getPlayoffs = async (req, res) => {
  try {
    const { tournament_category_id } = req.query;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const bracket = await Bracket.findOne({
      where: { tournament_category_id },
      include: [
        {
          model: Match,
          as: 'matches',
          include: includeMatchTeams()
        }
      ]
    });

    return sendSuccess(res, bracket);
  } catch (error) {
    console.error('Get playoffs error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener playoffs',
      details: error.message
    });
  }
};
