const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const venueController = require('../controllers/venueController');
const userController = require('../controllers/userController');
const rankingController = require('../controllers/rankingController');
const { authMiddleware, adminMiddleware } = require('../middleware/auth');

router.use(authMiddleware);
router.use(adminMiddleware);

router.get('/users', userController.getAllUsers);
router.post('/users', userController.createUserForPlayer);
router.patch('/users/:dni/password', userController.updateUserPassword);
router.delete('/users/:dni', userController.deleteUser);

router.post('/categories', adminController.createCategory);
router.put('/categories/:id', adminController.updateCategory);
router.delete('/categories/:id', adminController.deleteCategory);

router.get('/venues', venueController.getAllVenues);
router.post('/venues', venueController.createVenue);
router.put('/venues/:id', venueController.updateVenue);
router.delete('/venues/:id', venueController.deleteVenue);

router.get('/tournaments', adminController.getAllTournaments);
router.post('/tournaments', adminController.createTournament);
router.put('/tournaments/:id', adminController.updateTournament);
router.delete('/tournaments/:id', adminController.deleteTournament);

router.post('/tournament-categories', adminController.createTournamentCategory);
router.put('/tournament-categories/:id', adminController.updateTournamentCategory);

router.get('/teams', adminController.getAllTeams);
router.post('/teams', adminController.createTeamAdmin);
router.patch('/teams/:id/status', adminController.updateTeamStatus);

router.get('/registrations', adminController.getRegistrations);
router.post('/registrations', adminController.createRegistrationAdmin);
router.patch('/registrations/:id/cancel', adminController.cancelRegistration);
router.delete('/registrations/:id', adminController.deleteRegistration);

router.post('/zones/generate', adminController.generateZones);
router.post('/zones/generate-manual', adminController.generateZonesManual);
router.post('/zones/reset', adminController.resetZones);
router.patch('/zone-matches/:id/schedule', adminController.scheduleZoneMatch);
router.patch('/zone-matches/:id/result', adminController.updateZoneMatchResult);

router.post('/playoffs/generate', adminController.generatePlayoffs);
router.post('/playoffs/generate-manual', adminController.generatePlayoffsManual);
router.post('/playoffs/reset', adminController.resetPlayoffs);
router.patch('/matches/:id/result', adminController.updateMatchResult);
router.patch('/matches/:id/schedule', adminController.updateMatchSchedule);

router.post('/standings/rebuild', adminController.rebuildStandings);

router.post('/points/assign', rankingController.assignPoints);
router.get('/ranking', rankingController.getRanking);
router.get('/ranking/player/:dni', rankingController.getPlayerPoints);

module.exports = router;
