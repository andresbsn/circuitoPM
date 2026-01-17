const bcrypt = require('bcryptjs');
const { User, Category, PlayerProfile } = require('../models');

async function seed() {
  try {
    console.log('Starting seed process...');

    const categoriesData = [
      { name: '1ra', rank: 1 },
      { name: '2da', rank: 2 },
      { name: '3ra', rank: 3 },
      { name: '4ta', rank: 4 },
      { name: '5ta', rank: 5 },
      { name: '6ta', rank: 6 },
      { name: '7ma', rank: 7 },
      { name: '8va', rank: 8 }
    ];

    for (const catData of categoriesData) {
      await Category.findOrCreate({
        where: { name: catData.name },
        defaults: catData
      });
    }
    console.log('Categories seeded successfully.');

    const adminPassword = await bcrypt.hash('circPM_2026.', 10);
    const [adminUser, created] = await User.findOrCreate({
      where: { dni: 'admin' },
      defaults: {
        dni: 'admin',
        password_hash: adminPassword,
        role: 'admin'
      }
    });

    if (created) {
      console.log('Admin user created successfully (DNI: admin, Password: admin123)');
    } else {
      console.log('Admin user already exists.');
    }

    console.log('Seed process completed successfully.');
    process.exit(0);
  } catch (error) {
    console.error('Seed failed:', error);
    process.exit(1);
  }
}

seed();
