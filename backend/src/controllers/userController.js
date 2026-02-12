const { User, PlayerProfile, Category, Locality } = require('../models');
const bcrypt = require('bcryptjs');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError } = require('../utils/responseHelpers');
const { ERROR_CODES } = require('../utils/constants');

exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.findAll({
      attributes: ['dni', 'role', 'created_at'],
      include: [
        {
          model: PlayerProfile,
          as: 'playerProfile',
          include: [
            { model: Category, as: 'categoriaBase' },
            { model: Locality, as: 'locality' }
          ]
        }
      ],
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, users);
  } catch (error) {
    console.error('Get users error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener usuarios',
      details: error.message
    });
  }
};

exports.createUserForPlayer = async (req, res) => {
  try {
    const { dni, password } = req.body;

    if (!dni || !password) {
      return sendValidationError(res, 'DNI y contraseña son obligatorios');
    }

    // Verificar que el perfil del jugador existe
    const playerProfile = await PlayerProfile.findOne({ where: { dni } });
    if (!playerProfile) {
      return sendValidationError(res, 'No existe un perfil de jugador con ese DNI. Debe crear el perfil primero.');
    }

    // Verificar que no exista ya un usuario con ese DNI
    const existingUser = await User.findOne({ where: { dni } });
    if (existingUser) {
      return sendValidationError(res, 'Ya existe un usuario con ese DNI');
    }

    // Hashear contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear usuario
    const user = await User.create({
      dni,
      password: hashedPassword,
      role: 'player'
    });

    return sendSuccess(res, {
      dni: user.dni,
      role: user.role,
      profile: playerProfile
    }, 201);
  } catch (error) {
    console.error('Create user error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear usuario',
      details: error.message
    });
  }
};

exports.updateUserPassword = async (req, res) => {
  try {
    const { dni } = req.params;
    const { password } = req.body;

    if (!password) {
      return sendValidationError(res, 'La contraseña es obligatoria');
    }

    const user = await User.findOne({ where: { dni } });
    if (!user) {
      return sendNotFoundError(res, 'Usuario no encontrado');
    }

    // Hashear nueva contraseña
    const hashedPassword = await bcrypt.hash(password, 10);
    user.password = hashedPassword;
    await user.save();

    return sendSuccess(res, { message: 'Contraseña actualizada' });
  } catch (error) {
    console.error('Update password error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar contraseña',
      details: error.message
    });
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const { dni } = req.params;

    const user = await User.findOne({ where: { dni } });
    if (!user) {
      return sendNotFoundError(res, 'Usuario no encontrado');
    }

    if (user.role === 'admin') {
      return sendValidationError(res, 'No se puede eliminar un usuario administrador desde aquí');
    }

    await user.destroy();

    return sendSuccess(res, { message: 'Usuario eliminado' });
  } catch (error) {
    console.error('Delete user error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al eliminar usuario',
      details: error.message
    });
  }
};
