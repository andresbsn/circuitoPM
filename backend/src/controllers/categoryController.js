const { Category } = require('../models');
const { sendSuccess, sendError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');

exports.getCategories = async (req, res) => {
  try {
    const { gender } = req.query;
    const where = { active: true };
    
    if (gender) {
      where.gender = gender;
    }

    const categories = await Category.findAll({
      where,
      order: [['gender', 'ASC'], ['rank', 'ASC']]
    });

    return sendSuccess(res, categories);
  } catch (error) {
    console.error('Get categories error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener categorías',
      details: error.message
    });
  }
};
