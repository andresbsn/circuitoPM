const { sequelize } = require('../models');

async function migrate() {
  try {
    console.log('Testing database connection...');
    await sequelize.authenticate();
    console.log('Database connection established successfully.');

    const schema = process.env.DB_SCHEMA || 'public';
    
    if (schema !== 'public') {
      console.log(`Creating schema '${schema}' if it doesn't exist...`);
      await sequelize.query(`CREATE SCHEMA IF NOT EXISTS ${schema};`);
      console.log(`Schema '${schema}' ready.`);
    }

    console.log('Syncing database models...');
    await sequelize.sync({ alter: true });
    console.log('Database models synced successfully.');

    process.exit(0);
  } catch (error) {
    console.error('Migration failed:', error);
    process.exit(1);
  }
}

migrate();
