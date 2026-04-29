const { Category, Tournament, TournamentCategory, Registration, Team, PlayerProfile, Zone, ZoneTeam, ZoneMatch, ZoneStanding, Bracket, Match, Venue, User, Locality } = require('../models');
const bcrypt = require('bcryptjs');
const { generateZones, generateManualZones, recalculateStandings, updateDependentMatches } = require('../services/zoneService');
const { applyPromotionPoints } = require('../services/pointsService');
const { generateBracketFromZones, advanceWinnerToNextMatch } = require('../services/bracketService');
const { updatePlayoffsAfterZoneResults } = require('../services/playoffUpdateService');
const { validateScoreFormat, calculateMatchStats, validateTeamCategoryEligibility } = require('../utils/validation');
const { sequelize } = require('../models');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError, sendConflictError } = require('../utils/responseHelpers');
const { ERROR_CODES, TOURNAMENT_STATES, TOURNAMENT_CATEGORY_STATES, DEFAULT_VALUES, TEAM_STATES } = require('../utils/constants');
const { includeTeamWithPlayers, includeTournamentCategory, includeTournamentWithCategories, includeMatchTeams, includeZoneMatchTeams } = require('../utils/queryHelpers');
const { resolveFourTeamStandings } = require('../utils/zoneStandings');

const getPlayoffMatchFormat = (roundName, defaultFormat) => {
  if (!roundName) return defaultFormat;

  const normalized = roundName.toLowerCase();
  if (normalized.includes('octavos') || normalized.includes('cuartos') || normalized.includes('semifinal') || normalized === 'final') {
    return 'BEST_OF_3_FULL';
  }

  return defaultFormat;
};

exports.createCategory = async (req, res) => {
  try {
    const { name, rank, gender } = req.body;

    if (!name || rank === undefined) {
      return sendValidationError(res, 'Nombre y rank son obligatorios');
    }

    const category = await Category.create({
      name,
      rank,
      gender: gender || 'caballeros',
      active: true
    });

    return sendSuccess(res, category, 201);
  } catch (error) {
    console.error('Create category error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear categoría',
      details: error.message
    });
  }
};

exports.updateCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, rank, gender, active } = req.body;

    const category = await Category.findByPk(id);
    if (!category) {
      return res.status(404).json({
        ok: false,
        error: { code: 'NOT_FOUND', message: 'Categoría no encontrada' }
      });
    }

    if (name !== undefined) category.name = name;
    if (rank !== undefined) category.rank = rank;
    if (gender !== undefined) category.gender = gender;
    if (active !== undefined) category.active = active;

    await category.save();

    return sendSuccess(res, category);
  } catch (error) {
    console.error('Update category error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar categoría',
      details: error.message
    });
  }
};

exports.deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;

    const category = await Category.findByPk(id);
    if (!category) {
      return sendNotFoundError(res, 'Categoría no encontrada');
    }

    category.active = false;
    await category.save();

    return sendSuccess(res, { message: 'Categoría desactivada' });
  } catch (error) {
    console.error('Delete category error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al eliminar categoría',
      details: error.message
    });
  }
};

exports.createTournament = async (req, res) => {
  try {
    const { nombre, fecha_inicio, fecha_fin, descripcion, estado, double_points } = req.body;

    if (!nombre) {
      return sendValidationError(res, 'El nombre es obligatorio');
    }

    const tournament = await Tournament.create({
      nombre,
      fecha_inicio,
      fecha_fin,
      descripcion,
      estado: estado || TOURNAMENT_STATES.DRAFT,
      double_points: double_points ?? false
    });

    return sendSuccess(res, tournament, 201);
  } catch (error) {
    console.error('Create tournament error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear torneo',
      details: error.message
    });
  }
};

exports.updateTournament = async (req, res) => {
  try {
    const { id } = req.params;
    const { nombre, fecha_inicio, fecha_fin, descripcion, estado, double_points } = req.body;

    const tournament = await Tournament.findByPk(id);
    if (!tournament) {
      return sendNotFoundError(res, 'Torneo no encontrado');
    }

    if (nombre !== undefined) tournament.nombre = nombre;
    if (fecha_inicio !== undefined) tournament.fecha_inicio = fecha_inicio;
    if (fecha_fin !== undefined) tournament.fecha_fin = fecha_fin;
    if (descripcion !== undefined) tournament.descripcion = descripcion;
    if (estado !== undefined) tournament.estado = estado;
    if (double_points !== undefined) tournament.double_points = double_points;

    await tournament.save();

    return sendSuccess(res, tournament);
  } catch (error) {
    console.error('Update tournament error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar torneo',
      details: error.message
    });
  }
};

exports.deleteTournament = async (req, res) => {
  const transaction = await sequelize.transaction();
  try {
    const { id } = req.params;

    const tournament = await Tournament.findByPk(id, { transaction });
    if (!tournament) {
      await transaction.rollback();
      return sendNotFoundError(res, 'Torneo no encontrado');
    }

    // Only allow deletion if state is DRAFT
    if (tournament.estado !== TOURNAMENT_STATES.DRAFT) {
      await transaction.rollback();
      return sendError(res, {
        code: ERROR_CODES.FORBIDDEN,
        message: 'Solo se pueden eliminar torneos en estado borrador (draft)'
      }, 403);
    }

    // Find all tournament categories
    const categories = await TournamentCategory.findAll({
      where: { tournament_id: id },
      transaction
    });

    const categoryIds = categories.map(c => c.id);

    if (categoryIds.length > 0) {
      // 1. Delete associated Registrations
      await Registration.destroy({
        where: { tournament_category_id: categoryIds },
        transaction
      });

      // 2. Delete associated Zones (and their matches, teams, standings) if any
      // Since zone deletion is complex (many relations), we manually clear relations if necessary
      // Assuming straightforward cascade might not be set up in DB, we do best effort or rely on model cascades if set
      // But based on error, Registrations was the blocker.
      // Let's also clear Zones just in case
      const zones = await Zone.findAll({ where: { tournament_category_id: categoryIds }, transaction });
      const zoneIds = zones.map(z => z.id);

      if (zoneIds.length > 0) {
        await ZoneMatch.destroy({ where: { zone_id: zoneIds }, transaction });
        await ZoneStanding.destroy({ where: { zone_id: zoneIds }, transaction });
        await ZoneTeam.destroy({ where: { zone_id: zoneIds }, transaction });
        await Zone.destroy({ where: { id: zoneIds }, transaction });
      }

      // 3. Delete Brackets/Matches (Playoffs)
      // Similar approach if needed, or assume they don't exist in Draft.
      // But if user moved state back and forth, they might exist.
      // For now, let's stick to fixing the immediate "registration" error, which implies Registrations exist.

      // 4. Delete TournamentCategories
      await TournamentCategory.destroy({
        where: { tournament_id: id },
        transaction
      });
    }

    // 5. Finally delete the Tournament
    await tournament.destroy({ transaction });

    await transaction.commit();
    return sendSuccess(res, { message: 'Torneo eliminado' });
  } catch (error) {
    await transaction.rollback();
    console.error('Delete tournament error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al eliminar torneo',
      details: error.message
    });
  }
};

exports.getAllTournaments = async (req, res) => {
  try {
    const tournaments = await Tournament.findAll({
      include: [
        {
          model: TournamentCategory,
          as: 'categories',
          attributes: ['id', 'tournament_id', 'category_id', 'cupo', 'inscripcion_abierta', 'match_format', 'super_tiebreak_points', 'tiebreak_in_sets', 'win_points', 'loss_points', 'zone_size', 'qualifiers_per_zone', 'created_at', 'updated_at'],
          include: [{ model: Category, as: 'category' }]
        }
      ],
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, tournaments);
  } catch (error) {
    console.error('Get all tournaments error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener torneos',
      details: error.message
    });
  }
};

exports.createTournamentCategory = async (req, res) => {
  try {
    const { tournament_id, category_id, cupo, inscripcion_abierta, match_format, super_tiebreak_points, tiebreak_in_sets, win_points, loss_points } = req.body;

    if (!tournament_id || !category_id) {
      return sendValidationError(res, 'Tournament ID y Category ID son obligatorios');
    }

    const tournamentCategory = await TournamentCategory.create({
      tournament_id,
      category_id,
      cupo,
      inscripcion_abierta: inscripcion_abierta !== undefined ? inscripcion_abierta : true,
      match_format: match_format || DEFAULT_VALUES.MATCH_FORMAT,
      super_tiebreak_points: super_tiebreak_points || DEFAULT_VALUES.SUPER_TIEBREAK_POINTS,
      tiebreak_in_sets: tiebreak_in_sets !== undefined ? tiebreak_in_sets : DEFAULT_VALUES.TIEBREAK_IN_SETS,
      win_points: win_points || DEFAULT_VALUES.WIN_POINTS,
      loss_points: loss_points || DEFAULT_VALUES.LOSS_POINTS
    });

    const result = await TournamentCategory.findByPk(tournamentCategory.id, {
      include: [
        { model: Tournament, as: 'tournament' },
        { model: Category, as: 'category' }
      ]
    });

    return sendSuccess(res, result, 201);
  } catch (error) {
    console.error('Create tournament category error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear categoría de torneo',
      details: error.message
    });
  }
};

exports.updateTournamentCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const updates = req.body;

    const tournamentCategory = await TournamentCategory.findByPk(id);
    if (!tournamentCategory) {
      return sendNotFoundError(res, 'Categoría de torneo no encontrada');
    }

    await tournamentCategory.update(updates);

    const result = await TournamentCategory.findByPk(id, {
      include: [
        { model: Tournament, as: 'tournament' },
        { model: Category, as: 'category' }
      ]
    });

    return sendSuccess(res, result);
  } catch (error) {
    console.error('Update tournament category error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar categoría de torneo',
      details: error.message
    });
  }
};

exports.getRegistrations = async (req, res) => {
  try {
    const { tournamentId, categoryId, tournamentCategoryId } = req.query;

    const where = {};
    const include = [
      includeTournamentCategory(),
      includeTeamWithPlayers()
    ];

    if (tournamentCategoryId) {
      where.tournament_category_id = tournamentCategoryId;
    } else if (tournamentId) {
      // If we have tournamentId, we need to filter inside the include
      // However, includeTournamentCategory returns a complex include structure.
      // We need to modify it or add a where clause to it.
      // Since includeTournamentCategory() returns an object, we can modify it.
      const tcInclude = includeTournamentCategory();
      tcInclude.where = { tournament_id: tournamentId };
      
      if (categoryId) {
        tcInclude.where.category_id = categoryId;
      }
      
      // Replace the first include with our modified one
      include[0] = tcInclude;
    }

    const registrations = await Registration.findAll({
      where,
      include,
      order: [['created_at', 'DESC']]
    });

    return sendSuccess(res, registrations);
  } catch (error) {
    console.error('Get registrations error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener inscripciones',
      details: error.message
    });
  }
};

exports.createRegistrationAdmin = async (req, res) => {
  try {
    const { tournament_category_id, team_id } = req.body;

    if (!tournament_category_id || !team_id) {
      return sendValidationError(res, 'Todos los campos son obligatorios');
    }

    const tournamentCategory = await TournamentCategory.findByPk(tournament_category_id);
    if (!tournamentCategory) {
      return sendNotFoundError(res, 'Categoría de torneo no encontrada');
    }

    const team = await Team.findByPk(team_id, {
      include: [
        { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
        { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
      ]
    });

    if (!team) {
      return sendNotFoundError(res, 'Pareja no encontrada');
    }

    const validation = await validateTeamCategoryEligibility(team_id, tournament_category_id);
    if (!validation.valid) {
      return sendValidationError(res, validation.error);
    }

    const existingRegistration = await Registration.findOne({
      where: {
        tournament_category_id,
        team_id
      }
    });

    if (existingRegistration) {
      return sendError(res, {
        code: ERROR_CODES.CONFLICT,
        message: 'Esta pareja ya está inscrita en esta categoría'
      }, 409);
    }

    const registration = await Registration.create({
      tournament_category_id,
      team_id,
      estado: 'confirmado'
    });

    const registrationWithDetails = await Registration.findByPk(registration.id, {
      include: [
        includeTournamentCategory(),
        includeTeamWithPlayers()
      ]
    });

    return sendSuccess(res, registrationWithDetails, 201);
  } catch (error) {
    console.error('Create registration admin error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear inscripción',
      details: error.message
    });
  }
};

exports.cancelRegistration = async (req, res) => {
  try {
    const { id } = req.params;

    const registration = await Registration.findByPk(id);
    if (!registration) {
      return sendNotFoundError(res, 'Inscripción no encontrada');
    }

    registration.estado = 'cancelado';
    await registration.save();

    const updatedRegistration = await Registration.findByPk(id, {
      include: [
        includeTournamentCategory(),
        includeTeamWithPlayers()
      ]
    });

    return sendSuccess(res, updatedRegistration);
  } catch (error) {
    console.error('Cancel registration error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al cancelar inscripción',
      details: error.message
    });
  }
};

exports.deleteRegistration = async (req, res) => {
  try {
    const { id } = req.params;

    const registration = await Registration.findByPk(id);
    if (!registration) {
      return sendNotFoundError(res, 'Inscripción no encontrada');
    }

    await registration.destroy();

    return sendSuccess(res, { message: 'Inscripción eliminada' });
  } catch (error) {
    console.error('Delete registration error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al eliminar inscripción',
      details: error.message
    });
  }
};

exports.getAllTeams = async (req, res) => {
  try {
    const { category_id, estado } = req.query;

    const where = {};
    if (estado) {
      where.estado = estado;
    }

    let teams = await Team.findAll({
      where,
      include: [
        { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
        { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
      ],
      order: [['created_at', 'DESC']]
    });

    if (category_id) {
      teams = teams.filter(team =>
        team.player1.categoria_base_id === parseInt(category_id) ||
        team.player2.categoria_base_id === parseInt(category_id)
      );
    }

    return sendSuccess(res, teams);
  } catch (error) {
    console.error('Get all teams error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener parejas',
      details: error.message
    });
  }
};

exports.createTeamAdmin = async (req, res) => {
  try {
    const { player1_dni, player2_dni } = req.body;

    if (!player1_dni || !player2_dni) {
      return sendValidationError(res, 'Ambos DNIs son obligatorios');
    }

    if (player1_dni === player2_dni) {
      return sendValidationError(res, 'Los DNIs deben ser diferentes');
    }

    const player1 = await PlayerProfile.findByPk(player1_dni);
    const player2 = await PlayerProfile.findByPk(player2_dni);

    if (!player1 || !player2) {
      return sendNotFoundError(res, 'Uno o ambos jugadores no existen');
    }

    const existingTeam = await Team.findOne({
      where: {
        [require('sequelize').Op.or]: [
          { player1_dni, player2_dni },
          { player1_dni: player2_dni, player2_dni: player1_dni }
        ],
        estado: TEAM_STATES.ACTIVA
      }
    });

    if (existingTeam) {
      return sendError(res, {
        code: ERROR_CODES.TEAM_EXISTS,
        message: 'Ya existe una pareja activa con estos jugadores'
      }, 409);
    }

    const team = await Team.create({
      player1_dni,
      player2_dni,
      estado: TEAM_STATES.ACTIVA
    });

    const teamWithPlayers = await Team.findByPk(team.id, {
      include: [
        { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
        { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
      ]
    });

    return sendSuccess(res, teamWithPlayers, 201);
  } catch (error) {
    console.error('Create team admin error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al crear pareja',
      details: error.message
    });
  }
};

exports.updateTeamStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { estado } = req.body;

    if (!estado) {
      return sendValidationError(res, 'El estado es obligatorio');
    }

    const team = await Team.findByPk(id);
    if (!team) {
      return sendNotFoundError(res, 'Pareja no encontrada');
    }

    team.estado = estado;
    await team.save();

    const updatedTeam = await Team.findByPk(id, {
      include: [
        { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
        { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
      ]
    });

    return sendSuccess(res, updatedTeam);
  } catch (error) {
    console.error('Update team status error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar estado de pareja',
      details: error.message
    });
  }
};

exports.generateZonesManual = async (req, res) => {
  try {
    const { tournament_category_id, zones, force } = req.body;

    if (!tournament_category_id || !zones || !Array.isArray(zones)) {
      return sendValidationError(res, 'Datos inválidos');
    }

    const tournamentCategory = await TournamentCategory.findByPk(tournament_category_id);
    if (!tournamentCategory) {
      return sendNotFoundError(res, 'Categoría de torneo no encontrada');
    }

    // Use service to generate manual zones
    const { zones: result, isNew } = await generateManualZones(tournament_category_id, zones, force || false);

    return sendSuccess(res, { zones: result, isNew }, 201);
  } catch (error) {
    console.error('Generate manual zones error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message || 'Error al generar zonas manualmente',
      details: error.message
    });
  }
};

exports.generateZones = async (req, res) => {
  try {
    const { tournament_category_id, zone_size, qualifiers_per_zone, force } = req.body;

    if (!tournament_category_id || !zone_size || !qualifiers_per_zone) {
      return sendValidationError(res, 'Todos los campos son obligatorios');
    }

    const { zones, isNew } = await generateZones(tournament_category_id, zone_size, qualifiers_per_zone, force || false);

    const result = await Zone.findAll({
      where: { tournament_category_id },
      include: [
        {
          model: ZoneTeam,
          as: 'zoneTeams',
          include: [
            {
              model: Team,
              as: 'team',
              include: [
                { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
                { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
              ]
            }
          ]
        }
      ]
    });

    return sendSuccess(res, { zones: result, isNew }, isNew ? 201 : 200);
  } catch (error) {
    console.error('Generate zones error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message,
      details: error.message
    });
  }
};

exports.scheduleZoneMatch = async (req, res) => {
  try {
    const { id } = req.params;
    const { scheduled_at, venue } = req.body;

    const match = await ZoneMatch.findByPk(id);
    if (!match) {
      return sendNotFoundError(res, 'Partido no encontrado');
    }

    if (scheduled_at) {
      match.scheduled_at = new Date(scheduled_at);
    }
    if (venue !== undefined) {
      match.venue = venue;
    }

    await match.save();

    const updatedMatch = await ZoneMatch.findByPk(id, {
      include: [
        { model: Zone, as: 'zone' },
        ...includeZoneMatchTeams()
      ]
    });

    return sendSuccess(res, updatedMatch);
  } catch (error) {
    console.error('Schedule zone match error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al programar partido',
      details: error.message
    });
  }
};

exports.updateZoneMatchResult = async (req, res) => {
  try {
    const { id } = req.params;
    const { score_json, force_override } = req.body;

    const match = await ZoneMatch.findByPk(id, {
      include: [{ model: Zone, as: 'zone', include: [{ model: TournamentCategory, as: 'tournamentCategory' }] }]
    });

    if (!match) {
      return sendNotFoundError(res, 'Partido no encontrado');
    }

    if (match.status === 'played' && !force_override) {
      return sendConflictError(res, 'Este partido ya tiene un resultado cargado. Use force_override=true para sobrescribir.', match.score_json);
    }

    const tournamentCategory = match.zone.tournamentCategory;
    const validation = validateScoreFormat(score_json, tournamentCategory.match_format, tournamentCategory.super_tiebreak_points);

    if (!validation.valid) {
      return sendValidationError(res, validation.error);
    }

    const stats = calculateMatchStats(score_json);
    const winner_team_id = stats.winnerTeamId === 'home' ? match.team_home_id : match.team_away_id;

    const transaction = await sequelize.transaction();

    try {
      match.score_json = score_json;
      match.winner_team_id = winner_team_id;
      match.status = 'played';
      match.played_at = new Date();
      await match.save({ transaction });

      await recalculateStandings(match.zone_id, tournamentCategory.id, transaction);

      // Update dependent matches (e.g. for 4-team zones)
      await updateDependentMatches(match.id, transaction);

      // Actualizar playoffs automáticamente si existen
      await updatePlayoffsAfterZoneResults(match.zone_id, transaction);

      await transaction.commit();

      const updatedMatch = await ZoneMatch.findByPk(id, {
        include: includeZoneMatchTeams()
      });

      return sendSuccess(res, updatedMatch);
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    console.error('Update zone match result error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar resultado',
      details: error.message
    });
  }
};

exports.generatePlayoffs = async (req, res) => {
  try {
    const { tournament_category_id, force } = req.body;

    if (!tournament_category_id) {
      return sendValidationError(res, 'Tournament category ID es obligatorio');
    }

    const { bracket, isNew } = await generateBracketFromZones(tournament_category_id, force || false);

    const result = await Bracket.findByPk(bracket.id, {
      include: [
        {
          model: Match,
          as: 'matches',
          include: includeMatchTeams()
        }
      ],
      order: [
        [{ model: Match, as: 'matches' }, 'round_number', 'ASC'],
        [{ model: Match, as: 'matches' }, 'match_number', 'ASC']
      ]
    });

    return sendSuccess(res, { bracket: result, isNew }, isNew ? 201 : 200);
  } catch (error) {
    console.error('Generate playoffs error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message,
      details: error.message
    });
  }
};

exports.generatePlayoffsManual = async (req, res) => {
  try {
    const { tournament_category_id, total_slots, matches, force } = req.body;

    if (!tournament_category_id || !total_slots || !matches) {
      return sendValidationError(res, 'Faltan datos requeridos');
    }

    // Convert keys 'matches' (e.g. { matchNumber: 1, home: {...}, away: {...} }) 
    // to flat seededTeams array
    const seededTeams = new Array(total_slots).fill(null);

    matches.forEach(m => {
      // Inputs: m.match_number is 1-based (i.e. Match 1, Match 2...)
      // But we just need to place them in order.
      // Index for seededTeams:
      // Match 1 Home: 0
      // Match 1 Away: 1
      // Match 2 Home: 2
      // Match 2 Away: 3
      // ...
      const idx = (m.match_number - 1) * 2;

      if (m.home) {
        seededTeams[idx] = {
          zone_id: m.home.zone_id,
          position: m.home.position
        };
      }
      if (m.away) {
        seededTeams[idx + 1] = {
          zone_id: m.away.zone_id,
          position: m.away.position
        };
      }
    });

    // Call service that accepts seededTeams directly
    const { generateBracketManual } = require('../services/bracketService'); // ensure import
    const { bracket, isNew } = await generateBracketManual(tournament_category_id, seededTeams, force || false);

    const result = await Bracket.findByPk(bracket.id, {
      include: [
        { model: Match, as: 'matches', include: includeMatchTeams() }
      ],
      order: [
        [{ model: Match, as: 'matches' }, 'round_number', 'ASC'],
        [{ model: Match, as: 'matches' }, 'match_number', 'ASC']
      ]
    });

    return sendSuccess(res, { bracket: result, isNew }, isNew ? 201 : 200);

  } catch (error) {
    console.error('Manual playoffs error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: error.message,
      details: error.message
    });
  }
};

exports.updateMatchResult = async (req, res) => {
  try {
    const { id } = req.params;
    const { score_json, force_override } = req.body;

    const match = await Match.findByPk(id, {
      include: [{ model: Bracket, as: 'bracket', include: [{ model: TournamentCategory, as: 'tournamentCategory' }] }]
    });

    if (!match) {
      return res.status(404).json({
        ok: false,
        error: { code: 'NOT_FOUND', message: 'Partido no encontrado' }
      });
    }

    if (match.status === 'played' && !force_override) {
      return res.status(409).json({
        ok: false,
        error: {
          code: 'ALREADY_PLAYED',
          message: 'Este partido ya tiene un resultado cargado. Use force_override=true para sobrescribir.',
          current_score: match.score_json
        }
      });
    }

    const tournamentCategory = match.bracket.tournamentCategory;
    const effectiveMatchFormat = getPlayoffMatchFormat(match.round_name, tournamentCategory.match_format);
    const validation = validateScoreFormat(score_json, effectiveMatchFormat, tournamentCategory.super_tiebreak_points);

    if (!validation.valid) {
      return res.status(400).json({
        ok: false,
        error: { code: 'INVALID_SCORE', message: validation.error }
      });
    }

    const stats = calculateMatchStats(score_json);
    const winner_team_id = stats.winnerTeamId === 'home' ? match.team_home_id : match.team_away_id;

    const transaction = await sequelize.transaction();

    try {
      match.score_json = score_json;
      match.winner_team_id = winner_team_id;
      match.status = 'played';
      await match.save({ transaction });

      if (match.next_match_id) {
        await advanceWinnerToNextMatch(match.id, transaction);
      }

      await transaction.commit();

      const updatedMatch = await Match.findByPk(id, {
        include: [
          { model: Team, as: 'teamHome', include: [{ model: PlayerProfile, as: 'player1' }, { model: PlayerProfile, as: 'player2' }] },
          { model: Team, as: 'teamAway', include: [{ model: PlayerProfile, as: 'player1' }, { model: PlayerProfile, as: 'player2' }] },
          { model: Team, as: 'winner' }
        ]
      });

      return res.json({ ok: true, data: updatedMatch });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    console.error('Update match result error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al actualizar resultado', details: error.message }
    });
  }
};

exports.updateMatchSchedule = async (req, res) => {
  try {
    const { id } = req.params;
    const { scheduled_at, venue } = req.body;

    const match = await Match.findByPk(id);
    if (!match) {
      return sendNotFoundError(res, 'Partido no encontrado');
    }

    if (scheduled_at !== undefined) {
      match.scheduled_at = scheduled_at ? new Date(scheduled_at) : null;
    }
    if (venue !== undefined) {
      match.venue = venue;
    }

    await match.save();

    const updatedMatch = await Match.findByPk(id, {
      include: includeMatchTeams()
    });

    return sendSuccess(res, updatedMatch);
  } catch (error) {
    console.error('Update match schedule error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar horario',
      details: error.message
    });
  }
};

exports.resetZones = async (req, res) => {
  try {
    const { tournament_category_id, confirmed } = req.body;

    if (!tournament_category_id) {
      return res.status(400).json({
        ok: false,
        error: { code: 'MISSING_FIELDS', message: 'Tournament category ID es obligatorio' }
      });
    }

    if (!confirmed) {
      return res.status(400).json({
        ok: false,
        error: { code: 'CONFIRMATION_REQUIRED', message: 'Debe confirmar la eliminación de zonas con confirmed=true' }
      });
    }

    const transaction = await sequelize.transaction();

    try {
      const zones = await Zone.findAll({
        where: { tournament_category_id },
        transaction
      });

      if (zones.length === 0) {
        await transaction.rollback();
        return res.status(404).json({
          ok: false,
          error: { code: 'NOT_FOUND', message: 'No hay zonas para eliminar' }
        });
      }

      const zoneIds = zones.map(z => z.id);

      await ZoneStanding.destroy({
        where: { zone_id: zoneIds },
        transaction
      });

      await ZoneMatch.destroy({
        where: { zone_id: zoneIds },
        transaction
      });

      await ZoneTeam.destroy({
        where: { zone_id: zoneIds },
        transaction
      });

      await Zone.destroy({
        where: { tournament_category_id },
        transaction
      });

      await TournamentCategory.update(
        { estado: 'inscripcion_cerrada' },
        { where: { id: tournament_category_id }, transaction }
      );

      await transaction.commit();

      return res.json({ ok: true, data: { message: 'Zonas eliminadas exitosamente' } });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    console.error('Reset zones error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al eliminar zonas', details: error.message }
    });
  }
};

exports.resetPlayoffs = async (req, res) => {
  try {
    const { tournament_category_id, confirmed } = req.body;

    if (!tournament_category_id) {
      return res.status(400).json({
        ok: false,
        error: { code: 'MISSING_FIELDS', message: 'Tournament category ID es obligatorio' }
      });
    }

    if (!confirmed) {
      return res.status(400).json({
        ok: false,
        error: { code: 'CONFIRMATION_REQUIRED', message: 'Debe confirmar la eliminación de playoffs con confirmed=true' }
      });
    }

    const transaction = await sequelize.transaction();

    try {
      const bracket = await Bracket.findOne({
        where: { tournament_category_id },
        transaction
      });

      if (!bracket) {
        await transaction.rollback();
        return res.status(404).json({
          ok: false,
          error: { code: 'NOT_FOUND', message: 'No hay playoffs para eliminar' }
        });
      }

      const hasPlayedMatches = await Match.count({
        where: { bracket_id: bracket.id, status: 'played' },
        transaction
      });

      if (hasPlayedMatches > 0 && !confirmed) {
        await transaction.rollback();
        return res.status(400).json({
          ok: false,
          error: { code: 'HAS_PLAYED_MATCHES', message: 'Hay partidos jugados. Confirme la eliminación con confirmed=true' }
        });
      }

      await Match.destroy({
        where: { bracket_id: bracket.id },
        transaction
      });

      await bracket.destroy({ transaction });

      await TournamentCategory.update(
        { estado: 'zonas_en_curso' },
        { where: { id: tournament_category_id }, transaction }
      );

      await transaction.commit();

      return res.json({ ok: true, data: { message: 'Playoffs eliminados exitosamente' } });
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  } catch (error) {
    console.error('Reset playoffs error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al eliminar playoffs', details: error.message }
    });
  }
};

exports.rebuildStandings = async (req, res) => {
  try {
    const { zone_id } = req.body;

    if (!zone_id) {
      return res.status(400).json({
        ok: false,
        error: { code: 'MISSING_FIELDS', message: 'Zone ID es obligatorio' }
      });
    }

    const zone = await Zone.findByPk(zone_id, {
      include: [{ model: TournamentCategory, as: 'tournamentCategory' }]
    });

    if (!zone) {
      return res.status(404).json({
        ok: false,
        error: { code: 'NOT_FOUND', message: 'Zona no encontrada' }
      });
    }

    await recalculateStandings(zone_id, zone.tournament_category_id);

    const standingsOrder = [
      ['points', 'DESC'],
      ['sets_diff', 'DESC']
    ];

    const standings = await ZoneStanding.findAll({
      where: { zone_id },
      include: [
        {
          model: Team,
          as: 'team',
          include: [
            { model: PlayerProfile, as: 'player1', include: [{ model: Category, as: 'categoriaBase' }] },
            { model: PlayerProfile, as: 'player2', include: [{ model: Category, as: 'categoriaBase' }] }
          ]
        }
      ],
      order: standingsOrder
    });

    if (standings.length === 4) {
      const resolvedStandings = await resolveFourTeamStandings(zone_id, standings, null);
      if (resolvedStandings) {
        return res.json({ ok: true, data: resolvedStandings });
      }

      standings.sort((a, b) => {
        if (b.points !== a.points) return b.points - a.points;
        if (b.sets_diff !== a.sets_diff) return b.sets_diff - a.sets_diff;
        return 0;
      });
    }

    return res.json({ ok: true, data: standings });
  } catch (error) {
    console.error('Rebuild standings error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al recalcular standings', details: error.message }
    });
  }
};
exports.getAllPlayers = async (req, res) => {
  try {
    const { nombre, dni } = req.query;
    const { Op } = require('sequelize');

    const where = {};
    if (nombre) {
      where[Op.or] = [
        { nombre: { [Op.iLike]: `%${nombre}%` } },
        { apellido: { [Op.iLike]: `%${nombre}%` } }
      ];
    }
    if (dni) {
      where.dni = { [Op.like]: `%${dni}%` };
    }

    const players = await PlayerProfile.findAll({
      where,
      include: [
        { model: Category, as: 'categoriaBase' },
        { model: Locality, as: 'locality' }
      ],
      order: [['apellido', 'ASC'], ['nombre', 'ASC']]
    });

    return sendSuccess(res, players);
  } catch (error) {
    console.error('Get all players error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener jugadores',
      details: error.message
    });
  }
};

exports.getPlayerDetails = async (req, res) => {
  try {
    const { dni } = req.params;

    const player = await PlayerProfile.findByPk(dni, {
      include: [
        { model: Category, as: 'categoriaBase' },
        { model: Locality, as: 'locality' }
      ]
    });

    if (!player) {
      return sendNotFoundError(res, 'Jugador no encontrado');
    }

    // Buscar parejas donde participa el jugador
    const teams = await Team.findAll({
      where: {
        [require('sequelize').Op.or]: [
          { player1_dni: dni },
          { player2_dni: dni }
        ]
      },
      include: [
        { model: PlayerProfile, as: 'player1', attributes: ['dni', 'nombre', 'apellido'] },
        { model: PlayerProfile, as: 'player2', attributes: ['dni', 'nombre', 'apellido'] },
        {
          model: Registration,
          as: 'registrations',
          include: [
            {
              model: TournamentCategory,
              as: 'tournamentCategory',
              include: [
                { model: Tournament, as: 'tournament' },
                { model: Category, as: 'category' }
              ]
            }
          ]
        }
      ]
    });

    return sendSuccess(res, {
      player,
      teams
    });
  } catch (error) {
    console.error('Get player details error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al obtener detalles del jugador',
      details: error.message
    });
  }
};

exports.updatePlayer = async (req, res) => {
  try {
    const { dni } = req.params;
    const { nombre, apellido, telefono, categoria_base_id, genero, locality_id, activo, apply_promotion } = req.body;

    const player = await PlayerProfile.findByPk(dni);

    if (!player) {
      return sendNotFoundError(res, 'Jugador no encontrado');
    }

    const previousCategoryId = player.categoria_base_id;
    const transaction = await sequelize.transaction();

    try {
      if (nombre !== undefined) player.nombre = nombre;
      if (apellido !== undefined) player.apellido = apellido;
      if (telefono !== undefined) player.telefono = telefono;
      if (categoria_base_id !== undefined) player.categoria_base_id = categoria_base_id;
      if (genero !== undefined) player.genero = genero;
      if (locality_id !== undefined) player.locality_id = locality_id;
      if (activo !== undefined) player.activo = activo;

      await player.save({ transaction });

      let promotionResult = null;
      if (apply_promotion) {
        if (categoria_base_id === undefined || parseInt(categoria_base_id) === previousCategoryId) {
          throw new Error('El ascenso solo aplica cuando se cambia la categoría base');
        }

        const [fromCategory, toCategory] = await Promise.all([
          Category.findByPk(previousCategoryId, { transaction }),
          Category.findByPk(categoria_base_id, { transaction })
        ]);

        if (!fromCategory || !toCategory) {
          throw new Error('Categoría inválida para ascenso');
        }

        if (fromCategory.gender !== toCategory.gender || toCategory.rank >= fromCategory.rank) {
          throw new Error('El ascenso solo aplica al subir de categoría');
        }

        promotionResult = await applyPromotionPoints({
          playerDni: dni,
          fromCategoryId: previousCategoryId,
          toCategoryId: parseInt(categoria_base_id),
          transaction
        });
      }

      await transaction.commit();

      const updatedPlayer = await PlayerProfile.findByPk(dni, {
        include: [
          { model: Category, as: 'categoriaBase' },
          { model: Locality, as: 'locality' }
        ]
      });

      return sendSuccess(res, {
        player: updatedPlayer,
        promotion: promotionResult
      });
    } catch (error) {
      await transaction.rollback();
      if (error.message && (error.message.includes('ascenso') || error.message.includes('Categoría inválida'))) {
        return sendValidationError(res, error.message);
      }
      throw error;
    }
  } catch (error) {
    console.error('Update player error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al actualizar jugador',
      details: error.message
    });
  }
};
