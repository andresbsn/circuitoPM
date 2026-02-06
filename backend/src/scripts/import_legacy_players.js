const fs = require('fs');
const path = require('path');
const bcrypt = require('bcryptjs');
const sequelize = require('../config/database');

const User = require('../models/User');
const PlayerProfile = require('../models/PlayerProfile');
const Category = require('../models/Category');

// Initialize models if not already done by require (Sequelize needs init usually, but models here might be defined directly)
// We might need to manually init if they export a function, but looking at previous usages, they seem to be defined instances.
// Let's assume standard import works or define minimal models here to be safe if imports fail due to context.
// Actually, let's try to import them from the project structure.

async function importPlayers() {
    try {
        await sequelize.authenticate();
        console.log('Database connected.');

        // 1. Ensure Categories exist and get their IDs
        const categoryMapping = {
            1: '4ta',
            2: '5ta',
            3: '6ta',
            4: '7ma'
        };

        const categoryIds = {};

        for (const [legacyId, name] of Object.entries(categoryMapping)) {
            const [cat] = await Category.findOrCreate({
                where: { name },
                defaults: { name, gender: 'mixed' } // Assuming mixed or default
            });
            categoryIds[legacyId] = cat.id;
            console.log(`Category ${name} mapped to ID ${cat.id}`);
        }

        // 2. Read SQL File
        // Note: providing absolute path as requested or relative to script execution. 
        // User said: c:\Users\Modernizacion\Desktop\jugadores.sql
        const sqlPath = 'c:\\Users\\Modernizacion\\Desktop\\jugadores.sql';
        if (!fs.existsSync(sqlPath)) {
            console.error('SQL file not found at:', sqlPath);
            return;
        }

        const sqlContent = fs.readFileSync(sqlPath, 'utf8');

        // 3. Parse SQL
        // Pattern: (ID, IDCATEGORIA, NOMBRE, APELLIDO, APENOM, DNI, ...
        // Example: (1, 2, 'EMMANUEL', 'BELLI', 'BELLI EMMANUEL', '40057398', ...

        // Regex to match value groups. 
        // Matches: ( ... )
        // Inside: 
        // \d+ (ID)
        // \s*,\s*(\d+) (IDCATEGORIA -> Group 1)
        // \s*,\s*'([^']*)' (NOMBRE -> Group 2)
        // \s*,\s*'([^']*)' (APELLIDO -> Group 3)
        // \s*,\s*'[^']*' (APENOM - ignore)
        // \s*,\s*'([^']*)' (DNI -> Group 4)

        const regex = /\(\d+,\s*(\d+),\s*'([^']*)',\s*'([^']*)',\s*'[^']*',\s*'([^']*)'/g;

        let match;
        let count = 0;

        while ((match = regex.exec(sqlContent)) !== null) {
            const legacyCatId = parseInt(match[1]);
            const nombre = match[2];
            const apellido = match[3];
            const dni = match[4];

            // Filter based on legacy logic
            if (![1, 2, 3, 4].includes(legacyCatId)) {
                continue;
            }

            const targetCategoryId = categoryIds[legacyCatId];
            if (!targetCategoryId) {
                console.warn(`No target category for legacy ID ${legacyCatId}`);
                continue;
            }

            if (!dni || dni.length < 5) {
                console.warn(`Skipping invalid DNI: ${dni} for ${nombre} ${apellido}`);
                continue;
            }

            // Create User
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(dni, salt);

            try {
                const [user, createdUser] = await User.findOrCreate({
                    where: { dni },
                    defaults: {
                        dni,
                        password_hash: hashedPassword,
                        role: 'player',
                    }
                });

                if (createdUser) {
                    // console.log(`Created user for ${dni}`);
                }

                // Create or Update Profile
                const [profile, createdProfile] = await PlayerProfile.findOrCreate({
                    where: { dni },
                    defaults: {
                        dni,
                        nombre,
                        apellido,
                        categoria_base_id: targetCategoryId,
                        activo: true
                    }
                });

                if (!createdProfile) {
                    // Update category if needed
                    if (profile.categoria_base_id !== targetCategoryId) {
                        // profile.categoria_base_id = targetCategoryId; // Optional: Overwrite? User didn't specify. Safe to keep original? Let's keep original for now unless requested.
                    }
                }

                count++;
                if (count % 50 === 0) console.log(`Processed ${count} players...`);

            } catch (err) {
                console.error(`Error processing ${dni}:`, err.message);
            }
        }

        console.log(`Import completed. Processed ${count} valid players.`);

    } catch (error) {
        console.error('Migration failed:', error);
    } finally {
        await sequelize.close();
    }
}

importPlayers();
