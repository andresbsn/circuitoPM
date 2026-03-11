
const { sequelize } = require('../models');

async function checkColumns() {
  try {
    await sequelize.authenticate();
    const schema = 'padel_circuit'; // Hardcoded for check
    
    const tables = ['zones', 'zone_teams', 'matches'];
    
    for (const table of tables) {
      const [results] = await sequelize.query(`
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_schema = '${schema}' 
        AND table_name = '${table}';
      `);
      console.log(`Columns in ${table}:`, results.map(r => r.column_name).join(', '));
    }
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}
checkColumns();
