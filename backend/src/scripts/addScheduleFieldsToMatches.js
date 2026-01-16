const { sequelize } = require('../models');

async function addScheduleFields() {
  try {
    console.log('Agregando campos de programación a zone_matches y matches...\n');

    // Agregar campos a zone_matches
    await sequelize.query(`
      ALTER TABLE padel_circuit.zone_matches 
      ADD COLUMN IF NOT EXISTS venue VARCHAR(200);
    `);
    console.log('✅ Campo venue agregado a zone_matches');

    // Agregar campos a matches (playoffs)
    await sequelize.query(`
      ALTER TABLE padel_circuit.matches 
      ADD COLUMN IF NOT EXISTS scheduled_at TIMESTAMP;
    `);
    console.log('✅ Campo scheduled_at agregado a matches');

    await sequelize.query(`
      ALTER TABLE padel_circuit.matches 
      ADD COLUMN IF NOT EXISTS venue VARCHAR(200);
    `);
    console.log('✅ Campo venue agregado a matches');

    console.log('\n✅ Migración completada exitosamente');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error en la migración:', error);
    console.error('Detalles:', error.message);
    process.exit(1);
  }
}

addScheduleFields();
