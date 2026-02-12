const { Sequelize } = require('sequelize');
const sequelize = require('../config/database');

const SCHEMA = sequelize.options.define.schema || 'public';

const LOCALITIES = [
  { name: 'Ramallo', province: 'Buenos Aires' },
  { name: 'Villa Ramallo', province: 'Buenos Aires' },
  { name: 'Villa General Savio', province: 'Buenos Aires' },
  { name: 'El Paraíso', province: 'Buenos Aires' },
  { name: 'Pérez Millán', province: 'Buenos Aires' },
  { name: 'San Nicolás de los Arroyos', province: 'Buenos Aires' },
  { name: 'Villa Constitución', province: 'Santa Fe' },
  { name: 'San Pedro', province: 'Buenos Aires' },
  { name: 'Pergamino', province: 'Buenos Aires' },
  { name: 'Arrecifes', province: 'Buenos Aires' },
  { name: 'Baradero', province: 'Buenos Aires' },
  { name: 'Rosario', province: 'Santa Fe' },
  { name: 'La Emilia', province: 'Buenos Aires' },
  { name: 'Conesa', province: 'Buenos Aires' },
  { name: 'General Rojo', province: 'Buenos Aires' },
  { name: 'Campos Salles', province: 'Buenos Aires' },
  { name: 'Erezcano', province: 'Buenos Aires' }
];

async function migrate() {
  const transaction = await sequelize.transaction();

  try {
    console.log(`Starting migration to add localities in schema: ${SCHEMA}...`);

    // 1. Create localities table
    console.log('Creating localities table...');
    await sequelize.query(`
      CREATE TABLE IF NOT EXISTS "${SCHEMA}"."localities" (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        province VARCHAR(100) NOT NULL DEFAULT 'Buenos Aires'
      );
    `, { transaction });

    // 2. Add locality_id to player_profiles
    console.log('Adding locality_id to player_profiles...');
    
    // Check if column exists
    const [columns] = await sequelize.query(`
      SELECT column_name 
      FROM information_schema.columns 
      WHERE table_schema = '${SCHEMA}' AND table_name = 'player_profiles' AND column_name = 'locality_id';
    `, { transaction });

    if (columns.length === 0) {
      await sequelize.query(`
        ALTER TABLE "${SCHEMA}"."player_profiles" 
        ADD COLUMN locality_id INTEGER REFERENCES "${SCHEMA}"."localities"(id) ON DELETE SET NULL;
      `, { transaction });
    }

    // 3. Seed localities
    console.log('Seeding localities...');
    for (const loc of LOCALITIES) {
      // Check if exists to avoid duplicates
      const [existing] = await sequelize.query(`
        SELECT id FROM "${SCHEMA}"."localities" WHERE name = :name AND province = :province;
      `, { 
        replacements: { name: loc.name, province: loc.province },
        transaction 
      });

      if (existing.length === 0) {
        await sequelize.query(`
          INSERT INTO "${SCHEMA}"."localities" (name, province) VALUES (:name, :province);
        `, {
          replacements: { name: loc.name, province: loc.province },
          transaction
        });
      }
    }

    await transaction.commit();
    console.log('Migration completed successfully.');
  } catch (error) {
    await transaction.rollback();
    console.error('Migration failed:', error);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

migrate();
