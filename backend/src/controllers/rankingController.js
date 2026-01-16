const { assignTournamentPoints, getPlayerRanking, getPlayerPoints } = require('../services/pointsService');
const { sendSuccess, sendError, sendValidationError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');

/**
 * Asignar puntos al finalizar un torneo
 */
exports.assignPoints = async (req, res) => {
  try {
    const { tournament_category_id } = req.body;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const result = await assignTournamentPoints(tournament_category_id);

    return sendSuccess(res, result, 201);
  } catch (error) {
    console.error('Assign points error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message,
      details: error.message
    });
  }
};

/**
 * Obtener ranking de jugadores por categoría
 * Los puntos son independientes por categoría
 */
exports.getRanking = async (req, res) => {
  try {
    const { category_id, limit } = req.query;

    if (!category_id) {
      return sendValidationError(res, 'Se debe especificar una categoría (category_id) para ver el ranking');
    }

    const ranking = await getPlayerRanking(
      parseInt(category_id),
      limit ? parseInt(limit) : 100
    );

    return sendSuccess(res, ranking);
  } catch (error) {
    console.error('Get ranking error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener ranking',
      details: error.message
    });
  }
};

/**
 * Obtener puntos de un jugador específico
 */
exports.getPlayerPoints = async (req, res) => {
  try {
    const { dni } = req.params;

    if (!dni) {
      return sendValidationError(res, 'DNI es obligatorio');
    }

    const result = await getPlayerPoints(dni);

    return sendSuccess(res, result);
  } catch (error) {
    console.error('Get player points error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message,
      details: error.message
    });
  }
};
