const express = require('express');
const router = express.Router();
const tournamentController = require('../controllers/tournamentController');

router.get('/', tournamentController.getTournaments);
router.get('/:id', tournamentController.getTournamentById);

module.exports = router;
