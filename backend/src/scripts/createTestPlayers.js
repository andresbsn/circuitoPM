const bcrypt = require('bcryptjs');
const { User, PlayerProfile, Category } = require('../models');

async function createTestPlayers() {
  try {
    console.log('Creando jugadores de prueba...\n');

    // Buscar la categoría 4ta
    const category4ta = await Category.findOne({ where: { name: '4ta' } });
    
    if (!category4ta) {
      console.error('❌ No se encontró la categoría 4ta. Ejecuta el seed primero.');
      process.exit(1);
    }

    console.log(`✅ Categoría 4ta encontrada (ID: ${category4ta.id})\n`);

    // Datos de jugadores de prueba
    const testPlayers = [
      { dni: '30000001', nombre: 'Juan', apellido: 'Pérez', telefono: '1234567890' },
      { dni: '30000002', nombre: 'María', apellido: 'González', telefono: '1234567891' },
      { dni: '30000003', nombre: 'Carlos', apellido: 'Rodríguez', telefono: '1234567892' },
      { dni: '30000004', nombre: 'Ana', apellido: 'Martínez', telefono: '1234567893' },
      { dni: '30000005', nombre: 'Luis', apellido: 'López', telefono: '1234567894' },
      { dni: '30000006', nombre: 'Laura', apellido: 'Fernández', telefono: '1234567895' },
      { dni: '30000007', nombre: 'Diego', apellido: 'Sánchez', telefono: '1234567896' },
      { dni: '30000008', nombre: 'Sofía', apellido: 'Ramírez', telefono: '1234567897' },
      { dni: '30000009', nombre: 'Martín', apellido: 'Torres', telefono: '1234567898' },
      { dni: '30000010', nombre: 'Valentina', apellido: 'Flores', telefono: '1234567899' },
      { dni: '30000011', nombre: 'Facundo', apellido: 'Díaz', telefono: '1234567800' },
      { dni: '30000012', nombre: 'Camila', apellido: 'Romero', telefono: '1234567801' }
    ];

    const password = 'test123'; // Contraseña común para todos los usuarios de prueba
    const password_hash = await bcrypt.hash(password, 10);

    let created = 0;
    let skipped = 0;

    for (const player of testPlayers) {
      // Verificar si el usuario ya existe
      const existingUser = await User.findOne({ where: { dni: player.dni } });
      
      if (existingUser) {
        console.log(`⏭️  Usuario ${player.nombre} ${player.apellido} (DNI: ${player.dni}) ya existe`);
        skipped++;
        continue;
      }

      // Crear usuario
      await User.create({
        dni: player.dni,
        password_hash,
        role: 'player'
      });

      // Crear perfil de jugador
      await PlayerProfile.create({
        dni: player.dni,
        nombre: player.nombre,
        apellido: player.apellido,
        telefono: player.telefono,
        categoria_base_id: category4ta.id,
        activo: true
      });

      console.log(`✅ Creado: ${player.nombre} ${player.apellido} (DNI: ${player.dni})`);
      created++;
    }

    console.log('\n' + '='.repeat(50));
    console.log(`✅ Proceso completado`);
    console.log(`   Jugadores creados: ${created}`);
    console.log(`   Jugadores omitidos (ya existían): ${skipped}`);
    console.log(`   Total: ${testPlayers.length}`);
    console.log('='.repeat(50));
    console.log('\n📝 Credenciales de acceso:');
    console.log(`   DNI: 30000001 a 30000012`);
    console.log(`   Contraseña: test123`);
    console.log(`   Categoría: 4ta`);
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error al crear jugadores:', error);
    console.error('Detalles:', error.message);
    process.exit(1);
  }
}

createTestPlayers();
