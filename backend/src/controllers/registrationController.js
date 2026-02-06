const { Registration, TournamentCategory, Team, PlayerProfile, Category, Tournament } = require('../models');
const { validateRegistration } = require('../utils/validation');
const { Op } = require('sequelize');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError, sendForbiddenError } = require('../utils/responseHelpers');
const { ERROR_CODES, REGISTRATION_STATES } = require('../utils/constants');
const { includeTeamWithPlayers, includeTournamentCategory } = require('../utils/queryHelpers');

exports.createRegistration = async (req, res) => {
  try {
    const { tournament_category_id, team_id, schedule_problems } = req.body;
    const userDni = req.user.dni;

    if (!tournament_category_id || !team_id) {
      return sendValidationError(res, 'Todos los campos son obligatorios');
    }

    const team = await Team.findByPk(team_id);
    if (!team) {
      return sendNotFoundError(res, 'Pareja no encontrada');
    }

    if (team.player1_dni !== userDni && team.player2_dni !== userDni) {
      return sendForbiddenError(res, 'No tienes permiso para inscribir esta pareja');
    }

    const validation = await validateRegistration(team_id, tournament_category_id);
    if (!validation.valid) {
      return sendValidationError(res, validation.error);
    }

    const registration = await Registration.create({
      tournament_category_id,
      team_id,
      schedule_problems,
      estado: REGISTRATION_STATES.INSCRIPTO
    });

    const registrationWithDetails = await Registration.findByPk(registration.id, {
      include: [
        includeTournamentCategory(),
        includeTeamWithPlayers()
      ]
    });

    return sendSuccess(res, registrationWithDetails, 201);
  } catch (error) {
    console.error('Create registration error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear inscripción',
      details: error.message
    });
  }
};

exports.getMyRegistrations = async (req, res) => {
  try {
    const userDni = req.user.dni;

    const teams = await Team.findAll({
      where: {
        [Op.or]: [
          { player1_dni: userDni },
          { player2_dni: userDni }
        ]
      },
      attributes: ['id']
    });

    const teamIds = teams.map(t => t.id);

    const registrations = await Registration.findAll({
      where: {
        team_id: teamIds,
        estado: [REGISTRATION_STATES.INSCRIPTO, REGISTRATION_STATES.CONFIRMADO]
      },
      include: [
        includeTournamentCategory(),
        includeTeamWithPlayers()
      ],
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, registrations);
  } catch (error) {
    console.error('Get my registrations error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener inscripciones',
      details: error.message
    });
  }
};
