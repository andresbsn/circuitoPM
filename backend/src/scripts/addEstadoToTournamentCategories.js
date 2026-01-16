const { sequelize } = require('../models');

async function addEstadoColumn() {
  try {
    console.log('Agregando columna estado a tournament_categories...');

    await sequelize.query(`
      ALTER TABLE padel_circuit.tournament_categories 
      ADD COLUMN IF NOT EXISTS estado VARCHAR(50) DEFAULT 'draft';
    `);

    console.log('✅ Columna estado agregada exitosamente');

    // Opcional: Actualizar registros existentes
    await sequelize.query(`
      UPDATE padel_circuit.tournament_categories 
      SET estado = 'draft' 
      WHERE estado IS NULL;
    `);

    console.log('✅ Registros existentes actualizados');
    console.log('✅ Migración completada exitosamente');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error en la migración:', error);
    console.error('Detalles:', error.message);
    process.exit(1);
  }
}

addEstadoColumn();
