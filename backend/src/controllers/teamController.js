const { Team, PlayerProfile, Category, Registration } = require('../models');
const { Op } = require('sequelize');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError } = require('../utils/responseHelpers');
const { ERROR_CODES, TEAM_STATES } = require('../utils/constants');
const { getTeamWithPlayersById } = require('../utils/queryHelpers');

exports.createTeam = async (req, res) => {
  try {
    const { companion_dni } = req.body;
    const currentUserDni = req.user.dni;

    if (!companion_dni) {
      return sendValidationError(res, 'Debe proporcionar el DNI del compañero');
    }

    if (companion_dni === currentUserDni) {
      return sendValidationError(res, 'No puedes formar pareja contigo mismo');
    }

    const companion = await PlayerProfile.findByPk(companion_dni);
    if (!companion) {
      return sendNotFoundError(res, 'El compañero no está registrado en el sistema');
    }

    const existingTeam = await Team.findOne({
      where: {
        [Op.or]: [
          {
            player1_dni: currentUserDni,
            player2_dni: companion_dni
          },
          {
            player1_dni: companion_dni,
            player2_dni: currentUserDni
          }
        ]
      }
    });

    let team;

    if (existingTeam) {
      if (existingTeam.estado === TEAM_STATES.ACTIVA) {
        return sendError(res, {
          code: ERROR_CODES.TEAM_EXISTS,
          message: 'Ya existe una pareja activa con este compañero'
        }, 400);
      }

      // Si la pareja existe pero está inactiva, devolver error específico
      return sendError(res, {
        code: ERROR_CODES.TEAM_EXISTS,
        message: 'La pareja se encuentra inactiva, contactese con el administrador'
      }, 400);
    } else {
      // Create new team
      team = await Team.create({
        player1_dni: currentUserDni,
        player2_dni: companion_dni,
        estado: TEAM_STATES.ACTIVA
      });
    }

    const teamWithPlayers = await getTeamWithPlayersById(team.id);

    return sendSuccess(res, teamWithPlayers, 201);
  } catch (error) {
    console.error('Create team error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear la pareja',
      details: error.message
    });
  }
};

exports.getMyTeams = async (req, res) => {
  try {
    const userDni = req.user.dni;

    const teams = await Team.findAll({
      where: {
        [Op.or]: [
          { player1_dni: userDni },
          { player2_dni: userDni }
        ]
      },
      include: [
        { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
        { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
      ],
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, teams);
  } catch (error) {
    console.error('Get my teams error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener parejas',
      details: error.message
    });
  }
};
