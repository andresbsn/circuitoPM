const { Category, Tournament, TournamentCategory, Registration, Team, PlayerProfile, Zone, ZoneTeam, ZoneMatch, ZoneStanding, Bracket, Match, Venue, User } = require('../models');
const bcrypt = require('bcryptjs');
const { generateZones, recalculateStandings } = require('../services/zoneService');
const { generateBracketFromZones, advanceWinnerToNextMatch } = require('../services/bracketService');
const { updatePlayoffsAfterZoneResults } = require('../services/playoffUpdateService');
const { validateScoreFormat, calculateMatchStats } = require('../utils/validation');
const { sequelize } = require('../models');
const { sendSuccess, sendError, sendValidationError, sendNotFoundError, sendConflictError } = require('../utils/responseHelpers');
const { ERROR_CODES, TOURNAMENT_STATES, TOURNAMENT_CATEGORY_STATES, DEFAULT_VALUES, TEAM_STATES } = require('../utils/constants');
const { includeTeamWithPlayers, includeTournamentCategory, includeTournamentWithCategories, includeMatchTeams, includeZoneMatchTeams } = require('../utils/queryHelpers');

exports.createCategory = async (req, res) => {
  try {
    const { name, rank } = req.body;

    if (!name || rank === undefined) {
      return sendValidationError(res, 'Nombre y rank son obligatorios');
    }

    const category = await Category.create({ name, rank, active: true });

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
    const { name, rank, active } = req.body;

    const category = await Category.findByPk(id);
    if (!category) {
      return res.status(404).json({
        ok: false,
        error: { code: 'NOT_FOUND', message: 'Categoría no encontrada' }
      });
    }

    if (name !== undefined) category.name = name;
    if (rank !== undefined) category.rank = rank;
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
    const { nombre, fecha_inicio, fecha_fin, descripcion, estado } = req.body;

    if (!nombre) {
      return sendValidationError(res, 'El nombre es obligatorio');
    }

    const tournament = await Tournament.create({
      nombre,
      fecha_inicio,
      fecha_fin,
      descripcion,
      estado: estado || TOURNAMENT_STATES.DRAFT
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
    const { nombre, fecha_inicio, fecha_fin, descripcion, estado } = req.body;

    const tournament = await Tournament.findByPk(id);
    if (!tournament) {
      return sendNotFoundError(res, 'Torneo no encontrado');
    }

    if (nombre !== undefined) tournament.nombre = nombre;
    if (fecha_inicio !== undefined) tournament.fecha_inicio = fecha_inicio;
    if (fecha_fin !== undefined) tournament.fecha_fin = fecha_fin;
    if (descripcion !== undefined) tournament.descripcion = descripcion;
    if (estado !== undefined) tournament.estado = estado;

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
  try {
    const { id } = req.params;

    const tournament = await Tournament.findByPk(id);
    if (!tournament) {
      return sendNotFoundError(res, 'Torneo no encontrado');
    }

    await tournament.destroy();

    return sendSuccess(res, { message: 'Torneo eliminado' });
  } catch (error) {
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
    const { tournamentId, categoryId } = req.query;

    const where = {};
    if (tournamentId && categoryId) {
      const tournamentCategory = await TournamentCategory.findOne({
        where: { tournament_id: tournamentId, category_id: categoryId }
      });
      if (tournamentCategory) {
        where.tournament_category_id = tournamentCategory.id;
      }
    }

    const registrations = await Registration.findAll({
      where,
      include: [
        includeTournamentCategory(),
        includeTeamWithPlayers()
      ],
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
    const { tournament_category_id, zones } = req.body;

    if (!tournament_category_id || !zones || !Array.isArray(zones)) {
      return sendValidationError(res, 'Datos inválidos');
    }

    const tournamentCategory = await TournamentCategory.findByPk(tournament_category_id);
    if (!tournamentCategory) {
      return sendNotFoundError(res, 'Categoría de torneo no encontrada');
    }

    // Verificar si ya existen zonas
    const existingZones = await Zone.findAll({ where: { tournament_category_id } });
    if (existingZones.length > 0) {
      return sendError(res, {
        code: ERROR_CODES.CONFLICT,
        message: 'Ya existen zonas para esta categoría. Elimínelas primero.'
      }, 409);
    }

    await sequelize.transaction(async (t) => {
      // Crear zonas y asignar equipos
      for (const zoneData of zones) {
        const zone = await Zone.create({
          tournament_category_id,
          name: zoneData.name,
          order_index: zoneData.order_index
        }, { transaction: t });

        // Asignar equipos a la zona
        for (let i = 0; i < zoneData.teams.length; i++) {
          await ZoneTeam.create({
            zone_id: zone.id,
            team_id: zoneData.teams[i],
            order_index: i
          }, { transaction: t });

          // Crear standing inicial
          await ZoneStanding.create({
            zone_id: zone.id,
            team_id: zoneData.teams[i],
            played: 0,
            won: 0,
            lost: 0,
            sets_won: 0,
            sets_lost: 0,
            sets_diff: 0,
            games_won: 0,
            games_lost: 0,
            games_diff: 0,
            points: 0
          }, { transaction: t });
        }

        // Generar partidos round-robin para esta zona
        const teams = zoneData.teams;
        let matchNumber = 1;

        for (let round = 1; round <= teams.length - 1; round++) {
          for (let i = 0; i < teams.length / 2; i++) {
            const home = teams[i];
            const away = teams[teams.length - 1 - i];

            if (home && away) {
              await ZoneMatch.create({
                zone_id: zone.id,
                round_number: round,
                match_number: matchNumber++,
                team_home_id: home,
                team_away_id: away,
                status: 'pending'
              }, { transaction: t });
            }
          }

          // Rotar equipos (excepto el primero)
          teams.splice(1, 0, teams.pop());
        }
      }
    });

    // Obtener zonas creadas con todos los datos
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

    return sendSuccess(res, { zones: result, isNew: true }, 201);
  } catch (error) {
    console.error('Generate manual zones error:', error);
    return sendError(res, {
      code: ERROR_CODES.SERVER_ERROR,
      message: 'Error al generar zonas manualmente',
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

      await recalculateStandings(match.zone_id, tournamentCategory.id);

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
    const validation = validateScoreFormat(score_json, tournamentCategory.match_format, tournamentCategory.super_tiebreak_points);

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
    const { scheduled_at } = req.body;

    const match = await Match.findByPk(id);
    if (!match) {
      return res.status(404).json({
        ok: false,
        error: { code: 'NOT_FOUND', message: 'Partido no encontrado' }
      });
    }

    match.scheduled_at = scheduled_at;
    await match.save();

    return res.json({ ok: true, data: match });
  } catch (error) {
    console.error('Update match schedule error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al actualizar horario', details: error.message }
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
      order: [
        ['points', 'DESC'],
        ['sets_diff', 'DESC'],
        ['games_diff', 'DESC']
      ]
    });

    return res.json({ ok: true, data: standings });
  } catch (error) {
    console.error('Rebuild standings error:', error);
    return res.status(500).json({
      ok: false,
      error: { code: 'SERVER_ERROR', message: 'Error al recalcular standings', details: error.message }
    });
  }
};
