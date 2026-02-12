const { Locality } = require('../models');
const { sendSuccess, sendError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');

exports.getLocalities = async (req, res) => {
  try {
    const localities = await Locality.findAll({
      order: [['province', 'ASC'], ['name', 'ASC']]
    });

    return sendSuccess(res, localities);
  } catch (error) {
    console.error('Get localities error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener localidades',
      details: error.message
    });
  }
};
