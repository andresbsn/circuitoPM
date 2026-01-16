const { sequelize } = require('../models');

async function addDoublePointsColumn() {
  try {
    await sequelize.authenticate();
    console.log('Conexión establecida con la base de datos');

    console.log('\nAgregando columna double_points a tabla tournaments...');
    
    await sequelize.query(`
      ALTER TABLE padel_circuit.tournaments 
      ADD COLUMN IF NOT EXISTS double_points BOOLEAN NOT NULL DEFAULT false;
    `);

    console.log('Columna double_points agregada exitosamente');

    console.log('\n✅ Migración completada exitosamente');
    process.exit(0);
  } catch (error) {
    console.error('Error en migración:', error);
    process.exit(1);
  }
}

addDoublePointsColumn();
