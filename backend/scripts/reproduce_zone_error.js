
const { sequelize, Tournament, Category, TournamentCategory, Zone, Match, Bracket } = require('../src/models');

async function reproduce() {
  const transaction = await sequelize.transaction();
  try {
    console.log('Starting reproduction...');

    // 1. Create dummy data
    const tournament = await Tournament.create({ name: 'Test Tourn', status: 'borrador' }, { transaction });
    const category = await Category.create({ name: 'Test Cat', gender: 'caballeros' }, { transaction });
    const tc = await TournamentCategory.create({ 
      tournament_id: tournament.id, 
      category_id: category.id,
      match_format: 'set',
      scoring_type: 'traditional'
    }, { transaction });

    // 2. Create a Zone
    const zone = await Zone.create({
      tournament_category_id: tc.id,
      name: 'Zone A',
      order_index: 1
    }, { transaction });

    // 3. Create a Bracket and a Match referencing the Zone
    const bracket = await Bracket.create({
      tournament_category_id: tc.id,
      status: 'published'
    }, { transaction });

    const match = await Match.create({
      bracket_id: bracket.id,
      round_number: 1,
      round_name: 'Final',
      match_number: 1,
      home_source_zone_id: zone.id // Reference the zone
    }, { transaction });

    console.log('Created Zone:', zone.id);
    console.log('Created Match referencing Zone:', match.id);

    // 4. Try to delete the Zone (simulating validateAndClearZones)
    console.log('Attempting to destroy Zone...');
    await Zone.destroy({ where: { id: zone.id }, transaction });

    console.log('Zone destroyed successfully (Unexpected if FK exists)');
    await transaction.rollback();

  } catch (error) {
    console.error('Caught expected error:', error.message);
    if (error.original && error.original.code) {
        console.error('SQL Error Code:', error.original.code); // 23503 is FK violation
        console.error('SQL Error Detail:', error.original.detail);
    }
    await transaction.rollback();
  } finally {
    await sequelize.close();
  }
}

reproduce();
