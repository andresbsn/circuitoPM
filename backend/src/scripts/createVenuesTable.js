const { sequelize } = require('../models');

async function createVenuesTable() {
  try {
    console.log('Creando tabla de complejos...\n');

    await sequelize.query(`
      CREATE TABLE IF NOT EXISTS padel_circuit.venues (
        id SERIAL PRIMARY KEY,
        name VARCHAR(200) NOT NULL,
        address VARCHAR(300),
        courts_count INTEGER DEFAULT 1,
        active BOOLEAN DEFAULT true,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    console.log('✅ Tabla venues creada exitosamente');

    // Insertar algunos complejos de ejemplo
    await sequelize.query(`
      INSERT INTO padel_circuit.venues (name, address, courts_count, active)
      VALUES 
        ('Club Deportivo Central', 'Av. Principal 123', 4, true),
        ('Complejo Padel Norte', 'Calle Norte 456', 6, true),
        ('Centro Deportivo Sur', 'Av. Sur 789', 3, true)
      ON CONFLICT DO NOTHING;
    `);

    console.log('✅ Complejos de ejemplo insertados');
    console.log('\n✅ Migración completada exitosamente');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error en la migración:', error);
    console.error('Detalles:', error.message);
    process.exit(1);
  }
}

createVenuesTable();
