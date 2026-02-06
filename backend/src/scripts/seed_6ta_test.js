const { sequelize, User, PlayerProfile, Team, Category } = require('../models');
const { Op } = require('sequelize');

async function seed() {
    try {
        console.log('Iniciando seed de jugadores y parejas...');

        // 1. Buscar o crear Categoría 6ta
        let category = await Category.findOne({ where: { name: '6ta' } });
        if (!category) {
            console.log('Creando categoría 6ta...');
            category = await Category.create({
                name: '6ta',
                gender: 'masculino'
            });
        } else {
            console.log('Categoría 6ta encontrada (ID:', category.id, ')');
        }

        // 2. Crear 48 Jugadores (Usuario + Perfil)
        const players = [];
        for (let i = 1; i <= 48; i++) {
            const dni = `600000${i.toString().padStart(2, '0')}`;

            // Crear/Buscar Usuario
            let user = await User.findOne({ where: { dni } });
            if (!user) {
                user = await User.create({
                    dni: dni,
                    password_hash: 'dummy_hash_123', // Dummy password
                    role: 'player'
                });
            }

            // Crear/Buscar Perfil
            let player = await PlayerProfile.findOne({ where: { dni } });
            if (!player) {
                player = await PlayerProfile.create({
                    dni: dni,
                    nombre: `JugadorTest${i}`,
                    apellido: `6taCat`,
                    telefono: '11111111',
                    categoria_base_id: category.id
                });
            }
            players.push(player);
        }
        console.log(`${players.length} jugadores listos.`);

        // 3. Crear 24 Parejas
        let teamsCreated = 0;
        for (let i = 0; i < 48; i += 2) {
            const p1 = players[i];
            const p2 = players[i + 1];

            // Ordenar DNIs para evitar duplicados si la lógica lo requiere, aunque Op.or lo maneja
            // El modelo Team usa unique index en LEAST/GREATEST de dnis, así que el orden importa poco para la query de búsqueda pero Sequelize crea con el orden dado.

            const existingTeam = await Team.findOne({
                where: {
                    [Op.or]: [
                        { player1_dni: p1.dni, player2_dni: p2.dni },
                        { player1_dni: p2.dni, player2_dni: p1.dni }
                    ]
                }
            });

            if (!existingTeam) {
                await Team.create({
                    player1_dni: p1.dni,
                    player2_dni: p2.dni,
                    category_id: category.id, // Ojo: Team no tiene category_id en el modelo visto antes.
                    // Revisemos Team.js: no tiene category_id. Pero seeds anteriores usaban category_id?
                    // Team en index.js no muestra asociaciones explicitas de category.
                    // Si Team no tiene category, simplemente creamos la pareja.
                    estado: 'activa'
                });
                teamsCreated++;
            }
        }

        console.log(`Se crearon ${teamsCreated} nuevas parejas en categoría 6ta.`);
        console.log('Proceso finalizado con éxito.');

    } catch (error) {
        console.error('Error en seed:', error);
    } finally {
        // await sequelize.close(); // A veces cierra prematuramente si hay conexiones pool, pero en script está bien.
        process.exit(0);
    }
}

seed();
