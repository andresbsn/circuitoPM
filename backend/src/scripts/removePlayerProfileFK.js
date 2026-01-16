const { sequelize } = require('../models');

async function removeFK() {
  try {
    await sequelize.authenticate();
    console.log('Conexión establecida con la base de datos');

    // Eliminar la restricción de clave foránea
    console.log('\nEliminando restricción de clave foránea player_profiles_dni_fkey...');
    await sequelize.query(`
      ALTER TABLE padel_circuit.player_profiles 
      DROP CONSTRAINT IF EXISTS player_profiles_dni_fkey;
    `);

    console.log('✅ Restricción eliminada exitosamente');
    console.log('Ahora puedes crear jugadores sin necesidad de crear usuarios primero');

    process.exit(0);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

removeFK();
