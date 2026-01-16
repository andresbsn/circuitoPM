const express = require('express');
const router = express.Router();
const publicController = require('../controllers/publicController');
const rankingController = require('../controllers/rankingController');

router.get('/zones', publicController.getZones);
router.get('/standings', publicController.getStandings);
router.get('/zone-matches', publicController.getZoneMatches);
router.get('/playoffs', publicController.getPlayoffs);
router.get('/ranking', rankingController.getRanking);
router.get('/ranking/player/:dni', rankingController.getPlayerPoints);

module.exports = router;
