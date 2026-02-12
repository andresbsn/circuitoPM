const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { User, PlayerProfile, Category } = require('../models');
const { sendSuccess, sendError, sendValidationError, sendUnauthorizedError } = require('../utils/responseHelpers');
const { ERROR_CODES, USER_ROLES } = require('../utils/constants');

exports.register = async (req, res) => {
  try {
    const { dni, password, nombre, apellido, telefono, categoria_base_id, genero } = req.body;

    if (!dni || !password || !nombre || !apellido || !categoria_base_id || !genero) {
      return sendValidationError(res, 'Todos los campos son obligatorios');
    }

    const existingUser = await User.findOne({ where: { dni } });
    if (existingUser) {
      return sendError(res, {
        code: ERROR_CODES.USER_EXISTS,
        message: 'Ya existe un usuario con ese DNI'
      }, 400);
    }

    const category = await Category.findByPk(categoria_base_id);
    if (!category) {
      return sendValidationError(res, 'Categoría inválida');
    }

    const password_hash = await bcrypt.hash(password, 10);

    const user = await User.create({
      dni,
      password_hash,
      role: USER_ROLES.PLAYER
    });

    await PlayerProfile.create({
      dni,
      nombre,
      apellido,
      telefono,
      categoria_base_id,
      genero,
      activo: true
    });

    const token = jwt.sign(
      { id: user.id, dni: user.dni, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    return sendSuccess(res, {
      token,
      user: {
        id: user.id,
        dni: user.dni,
        role: user.role
      }
    }, 201);
  } catch (error) {
    console.error('Register error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al registrar usuario',
      details: error.message
    });
  }
};

exports.login = async (req, res) => {
  try {
    const { dni, password } = req.body;

    if (!dni || !password) {
      return sendValidationError(res, 'DNI y contraseña son obligatorios');
    }

    const user = await User.findOne({ 
      where: { dni },
      include: [{ model: PlayerProfile, as: 'playerProfile' }]
    });

    if (!user) {
      return sendUnauthorizedError(res, 'DNI o contraseña incorrectos');
    }

    const isValidPassword = await bcrypt.compare(password, user.password_hash);
    if (!isValidPassword) {
      return sendUnauthorizedError(res, 'DNI o contraseña incorrectos');
    }

    const token = jwt.sign(
      { id: user.id, dni: user.dni, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: '7d' }
    );

    return sendSuccess(res, {
      token,
      user: {
        id: user.id,
        dni: user.dni,
        role: user.role,
        profile: user.playerProfile
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al iniciar sesión',
      details: error.message
    });
  }
};

exports.me = async (req, res) => {
  try {
    const user = await User.findByPk(req.user.id, {
      include: [{ 
        model: PlayerProfile, 
        as: 'playerProfile',
        include: [{ model: Category, as: 'categoriaBase' }]
      }]
    });

    return sendSuccess(res, {
      id: user.id,
      dni: user.dni,
      role: user.role,
      profile: user.playerProfile
    });
  } catch (error) {
    console.error('Me error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener datos del usuario',
      details: error.message
    });
  }
};
