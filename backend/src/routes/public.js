const express = require('express');
const router = express.Router();
const publicController = require('../controllers/publicController');
const rankingController = require('../controllers/rankingController');
const localityController = require('../controllers/localityController');

router.get('/zones', publicController.getZones);
router.get('/standings', publicController.getStandings);
router.get('/zone-matches', publicController.getZoneMatches);
router.get('/playoffs', publicController.getPlayoffs);
router.get('/ranking', rankingController.getRanking);
router.get('/ranking/player/:dni', rankingController.getPlayerPoints);
router.get('/localities', localityController.getLocalities);

module.exports = router;
