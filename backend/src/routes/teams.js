const express = require('express');
const router = express.Router();
const teamController = require('../controllers/teamController');
const { authMiddleware } = require('../middleware/auth');

router.post('/', authMiddleware, teamController.createTeam);
router.get('/me', authMiddleware, teamController.getMyTeams);

module.exports = router;
