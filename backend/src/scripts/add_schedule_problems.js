const { Sequelize } = require('sequelize');
const sequelize = require('../config/database');

const SCHEMA = sequelize.options.define.schema || 'public';

async function migrate() {
  const transaction = await sequelize.transaction();

  try {
    console.log(`Starting migration to add schedule_problems to registrations in schema: ${SCHEMA}...`);

    // Check if column exists
    const [columns] = await sequelize.query(`
      SELECT column_name 
      FROM information_schema.columns 
      WHERE table_schema = '${SCHEMA}' AND table_name = 'registrations' AND column_name = 'schedule_problems';
    `, { transaction });

    if (columns.length === 0) {
      console.log('Adding schedule_problems column to registrations table...');
      await sequelize.query(`
        ALTER TABLE "${SCHEMA}"."registrations" 
        ADD COLUMN schedule_problems TEXT;
      `, { transaction });
      console.log('Column added successfully.');
    } else {
      console.log('Column schedule_problems already exists.');
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
