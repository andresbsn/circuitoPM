const bcrypt = require('bcryptjs');
const { User, PlayerProfile, Category } = require('../models');

async function seedPartner() {
    try {
        const password = await bcrypt.hash('123456', 10);
        // Create a dummy partner
        await User.findOrCreate({
            where: { dni: '11111111' },
            defaults: {
                dni: '11111111',
                password_hash: password,
                role: 'player'
            }
        });

        // Get a category
        let category = await Category.findOne();
        if (!category) {
            // Fallback if categories not seeded
            category = await Category.create({ name: '8va', rank: 8 });
        }

        await PlayerProfile.findOrCreate({
            where: { dni: '11111111' },
            defaults: {
                dni: '11111111',
                nombre: 'Compañero',
                apellido: 'Ejemplo',
                categoria_base_id: category.id,
                telefono: '111111111'
            }
        });

        console.log('Partner user created: 11111111');
        process.exit(0);
    } catch (e) {
        console.error(e);
        process.exit(1);
    }
}
seedPartner();
