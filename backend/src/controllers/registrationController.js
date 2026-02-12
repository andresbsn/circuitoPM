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

exports.updateRegistration = async (req, res) => {
  try {
    const { id } = req.params;
    const { schedule_problems } = req.body;
    const userDni = req.user.dni;

    const registration = await Registration.findByPk(id, {
      include: [
        { 
          model: Team, 
          as: 'team' 
        },
        {
          model: TournamentCategory,
          as: 'tournamentCategory',
          include: [{ model: Tournament, as: 'tournament' }]
        }
      ]
    });

    if (!registration) {
      return sendNotFoundError(res, 'Inscripción no encontrada');
    }

    // Verify ownership
    if (registration.team.player1_dni !== userDni && registration.team.player2_dni !== userDni) {
      return sendForbiddenError(res, 'No tienes permiso para modificar esta inscripción');
    }

    // Verify tournament state
    const tournamentState = registration.tournamentCategory.tournament.estado;
    if (tournamentState === 'en_curso' || tournamentState === 'finalizado') {
      return sendValidationError(res, 'No se puede modificar la inscripción una vez iniciado el torneo');
    }

    registration.schedule_problems = schedule_problems;
    await registration.save();

    return sendSuccess(res, registration);
  } catch (error) {
    console.error('Update registration error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar inscripción',
      details: error.message
    });
  }
};

exports.cancelRegistration = async (req, res) => {
  try {
    const { id } = req.params;
    const userDni = req.user.dni;

    const registration = await Registration.findByPk(id, {
      include: [
        { 
          model: Team, 
          as: 'team' 
        },
        {
          model: TournamentCategory,
          as: 'tournamentCategory',
          include: [{ model: Tournament, as: 'tournament' }]
        }
      ]
    });

    if (!registration) {
      return sendNotFoundError(res, 'Inscripción no encontrada');
    }

    // Verify ownership
    if (registration.team.player1_dni !== userDni && registration.team.player2_dni !== userDni) {
      return sendForbiddenError(res, 'No tienes permiso para cancelar esta inscripción');
    }

    // Verify tournament state
    const tournamentState = registration.tournamentCategory.tournament.estado;
    if (tournamentState === 'en_curso' || tournamentState === 'finalizado') {
      return sendValidationError(res, 'No se puede cancelar la inscripción una vez iniciado el torneo');
    }

    // We can either delete it or mark as cancelled. 
    // Usually marking as cancelled is safer, or deleting if it's just a draft.
    // The previous code in adminController uses 'cancelado' state or destroy.
    // Let's use destroy if it's just 'inscripto' to keep it clean, or update state.
    // User request: "darse de baja". 
    // Let's use destroy to remove it completely from the list if the user cancels it themselves, 
    // or set to 'cancelado' so they can see history? 
    // Admin delete uses destroy. Admin cancel uses state 'cancelado'.
    // If I use destroy, they can register again easily. 
    // Let's use destroy for now as it's cleaner for "darse de baja" unless we want to keep record.
    // However, if we want to keep history, 'cancelado' is better.
    // But if 'cancelado', can they re-register? validation checks for existing registration.
    // Let's check createRegistration... it checks `validateRegistration` which probably checks for existing.
    // Let's stick to destroy for user cancellation so they can re-register if they made a mistake.
    
    await registration.destroy();

    return sendSuccess(res, { message: 'Inscripción cancelada exitosamente' });
  } catch (error) {
    console.error('Cancel registration error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al cancelar inscripción',
      details: error.message
    });
  }
};
