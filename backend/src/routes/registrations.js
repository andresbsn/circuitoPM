const express = require('express');
const router = express.Router();
const registrationController = require('../controllers/registrationController');
const { authMiddleware } = require('../middleware/auth');

router.post('/', authMiddleware, registrationController.createRegistration);
router.get('/me', authMiddleware, registrationController.getMyRegistrations);
router.patch('/:id', authMiddleware, registrationController.updateRegistration);
router.delete('/:id', authMiddleware, registrationController.cancelRegistration);

module.exports = router;
