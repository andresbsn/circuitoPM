const { sequelize } = require('../models');

async function createTournamentPointsTable() {
  try {
    await sequelize.authenticate();
    console.log('Conexión establecida con la base de datos');

    console.log('\nCreando tabla tournament_points...');
    
    await sequelize.query(`
      CREATE TABLE IF NOT EXISTS padel_circuit.tournament_points (
        id SERIAL PRIMARY KEY,
        tournament_category_id INTEGER NOT NULL REFERENCES padel_circuit.tournament_categories(id) ON DELETE CASCADE,
        player_dni VARCHAR(20) NOT NULL REFERENCES padel_circuit.player_profiles(dni) ON DELETE CASCADE,
        team_id INTEGER NOT NULL REFERENCES padel_circuit.teams(id) ON DELETE CASCADE,
        points INTEGER NOT NULL DEFAULT 0,
        position VARCHAR(50) NOT NULL,
        awarded_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
        CONSTRAINT tournament_points_unique UNIQUE (tournament_category_id, player_dni)
      );
    `);

    console.log('Tabla tournament_points creada exitosamente');

    console.log('\nCreando índices...');
    
    await sequelize.query(`
      CREATE INDEX IF NOT EXISTS idx_tournament_points_player 
      ON padel_circuit.tournament_points(player_dni);
    `);

    await sequelize.query(`
      CREATE INDEX IF NOT EXISTS idx_tournament_points_tournament_category 
      ON padel_circuit.tournament_points(tournament_category_id);
    `);

    console.log('Índices creados exitosamente');

    console.log('\n✅ Migración completada exitosamente');
    process.exit(0);
  } catch (error) {
    console.error('Error en migración:', error);
    process.exit(1);
  }
}

createTournamentPointsTable();
