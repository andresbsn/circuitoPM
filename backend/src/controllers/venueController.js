const { Venue } = require('../models');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');

exports.getAllVenues = async (req, res) => {
  try {
    const { active } = req.query;
    const where = {};
    
    if (active !== undefined) {
      where.active = active === 'true';
    }

    const venues = await Venue.findAll({
      where,
      order: [['name', 'ASC']]
    });

    return sendSuccess(res, venues);
  } catch (error) {
    console.error('Get venues error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener complejos',
      details: error.message
    });
  }
};

exports.createVenue = async (req, res) => {
  try {
    const { name, address, courts_count } = req.body;

    if (!name) {
      return sendValidationError(res, 'El nombre es obligatorio');
    }

    const venue = await Venue.create({
      name,
      address,
      courts_count: courts_count || 1,
      active: true
    });

    return sendSuccess(res, venue, 201);
  } catch (error) {
    console.error('Create venue error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear complejo',
      details: error.message
    });
  }
};

exports.updateVenue = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, address, courts_count, active } = req.body;

    const venue = await Venue.findByPk(id);
    if (!venue) {
      return sendNotFoundError(res, 'Complejo no encontrado');
    }

    if (name !== undefined) venue.name = name;
    if (address !== undefined) venue.address = address;
    if (courts_count !== undefined) venue.courts_count = courts_count;
    if (active !== undefined) venue.active = active;

    await venue.save();

    return sendSuccess(res, venue);
  } catch (error) {
    console.error('Update venue error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar complejo',
      details: error.message
    });
  }
};

exports.deleteVenue = async (req, res) => {
  try {
    const { id } = req.params;

    const venue = await Venue.findByPk(id);
    if (!venue) {
      return sendNotFoundError(res, 'Complejo no encontrado');
    }

    await venue.destroy();

    return sendSuccess(res, { message: 'Complejo eliminado' });
  } catch (error) {
    console.error('Delete venue error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al eliminar complejo',
      details: error.message
    });
  }
};
