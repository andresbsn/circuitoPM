const sendSuccess = (res, data, statusCode = 200) => {
  return res.status(statusCode).json({
    ok: true,
    data
  });
};

const sendError = (res, error, statusCode = 500) => {
  const errorResponse = {
    ok: false,
    error: {
      code: error.code || 'SERVER_ERROR',
      message: error.message || 'Error interno del servidor',
      details: process.env.NODE_ENV === 'development' ? error.details : undefined
    }
  };

  return res.status(statusCode).json(errorResponse);
};

const sendValidationError = (res, message) => {
  return sendError(res, {
    code: 'VALIDATION_ERROR',
    message
  }, 400);
};

const sendNotFoundError = (res, message = 'Recurso no encontrado') => {
  return sendError(res, {
    code: 'NOT_FOUND',
    message
  }, 404);
};

const sendUnauthorizedError = (res, message = 'No autorizado') => {
  return sendError(res, {
    code: 'UNAUTHORIZED',
    message
  }, 401);
};

const sendForbiddenError = (res, message = 'Acceso denegado') => {
  return sendError(res, {
    code: 'FORBIDDEN',
    message
  }, 403);
};

const sendConflictError = (res, message, currentData = null) => {
  return res.status(409).json({
    ok: false,
    error: {
      code: 'CONFLICT',
      message,
      current_data: currentData
    }
  });
};

module.exports = {
  sendSuccess,
  sendError,
  sendValidationError,
  sendNotFoundError,
  sendUnauthorizedError,
  sendForbiddenError,
  sendConflictError
};
