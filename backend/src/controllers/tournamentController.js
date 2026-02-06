const { Tournament, TournamentCategory, Category, Registration, Team, PlayerProfile } = require('../models');
const { sendSuccess, sendError, sendNotFoundError } = require('../utils/responseHelpers');
const { ERROR_CODES, TOURNAMENT_STATES } = require('../utils/constants');
const { includeTournamentWithCategories } = require('../utils/queryHelpers');

exports.getTournaments = async (req, res) => {
  try {
    const { public: isPublic } = req.query;

    const where = {};
    if (isPublic === 'true') {
      where.estado = [TOURNAMENT_STATES.EN_CURSO, TOURNAMENT_STATES.FINALIZADO];
    } else {
      where.estado = [TOURNAMENT_STATES.INSCRIPCION, TOURNAMENT_STATES.EN_CURSO, TOURNAMENT_STATES.FINALIZADO];
    }

    const tournaments = await Tournament.findAll({
      where,
      include: [
        {
          model: TournamentCategory,
          as: 'categories',
          attributes: ['id', 'tournament_id', 'category_id', 'cupo', 'inscripcion_abierta', 'match_format', 'super_tiebreak_points', 'tiebreak_in_sets', 'win_points', 'loss_points', 'zone_size', 'qualifiers_per_zone', 'created_at', 'updated_at'],
          include: [{ model: Category, as: 'category' }]
        }
      ],
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, tournaments);
  } catch (error) {
    console.error('Get tournaments error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener torneos',
      details: error.message
    });
  }
};

exports.getTournamentById = async (req, res) => {
  try {
    const { id } = req.params;

    const tournament = await Tournament.findByPk(id, {
      include: [
        {
          model: TournamentCategory,
          as: 'categories',
          attributes: ['id', 'tournament_id', 'category_id', 'cupo', 'inscripcion_abierta', 'match_format', 'super_tiebreak_points', 'tiebreak_in_sets', 'win_points', 'loss_points', 'zone_size', 'qualifiers_per_zone', 'created_at', 'updated_at'],
          include: [
            { model: Category, as: 'category' },
            { model: Registration, as: 'registrations' }
          ]
        }
      ]
    });

    if (!tournament) {
      return sendNotFoundError(res, 'Torneo no encontrado');
    }

    return sendSuccess(res, tournament);
  } catch (error) {
    console.error('Get tournament error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener torneo',
      details: error.message
    });
  }
};
