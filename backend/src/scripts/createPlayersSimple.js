const { sequelize } = require('../models');

async function createPlayersSimple() {
  try {
    await sequelize.authenticate();
    console.log('Conexión establecida con la base de datos');

    // Crear jugadores directamente con SQL para evitar restricciones de Sequelize
    const dniStart = 30000013;
    const playersPerCategory = 48;

    console.log('\nCreando 48 jugadores de 4ta categoría...');
    for (let i = 0; i < playersPerCategory; i++) {
      const dni = String(dniStart + i);
      const nombre = `Jugador4ta`;
      const apellido = `Test${i + 1}`;
      const telefono = `11${5000 + i}${6000 + i}`;
      
      await sequelize.query(`
        INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at)
        VALUES (:dni, :nombre, :apellido, :telefono, 4, true, NOW(), NOW())
        ON CONFLICT (dni) DO NOTHING
      `, {
        replacements: { dni, nombre, apellido, telefono }
      });
    }

    console.log('Creando 48 jugadores de 5ta categoría...');
    for (let i = 0; i < playersPerCategory; i++) {
      const dni = String(dniStart + playersPerCategory + i);
      const nombre = `Jugador5ta`;
      const apellido = `Test${i + 1}`;
      const telefono = `11${7000 + i}${8000 + i}`;
      
      await sequelize.query(`
        INSERT INTO padel_circuit.player_profiles (dni, nombre, apellido, telefono, categoria_base_id, activo, created_at, updated_at)
        VALUES (:dni, :nombre, :apellido, :telefono, 5, true, NOW(), NOW())
        ON CONFLICT (dni) DO NOTHING
      `, {
        replacements: { dni, nombre, apellido, telefono }
      });
    }

    // Verificar totales
    const [results] = await sequelize.query(`
      SELECT categoria_base_id, COUNT(*) as total
      FROM padel_circuit.player_profiles
      WHERE categoria_base_id IN (4, 5)
      GROUP BY categoria_base_id
      ORDER BY categoria_base_id
    `);

    console.log('\n✅ Jugadores creados exitosamente!');
    console.log('\n📊 Totales en base de datos:');
    results.forEach(row => {
      const catName = row.categoria_base_id === 4 ? '4ta' : '5ta';
      console.log(`Jugadores de ${catName}: ${row.total}`);
    });

    process.exit(0);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

createPlayersSimple();
