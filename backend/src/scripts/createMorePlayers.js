const { sequelize, PlayerProfile, Category } = require('../models');

async function createMorePlayers() {
  try {
    await sequelize.authenticate();
    console.log('Conexión establecida con la base de datos');

    // Obtener categorías 4ta y 5ta
    const cat4 = await Category.findOne({ where: { name: '4ta' } });
    const cat5 = await Category.findOne({ where: { name: '5ta' } });

    if (!cat4 || !cat5) {
      console.error('No se encontraron las categorías 4ta y 5ta');
      process.exit(1);
    }

    console.log('Categorías encontradas:', { cat4: cat4.name, cat5: cat5.name });

    // Verificar jugadores existentes
    const existing4ta = await PlayerProfile.count({ where: { categoria_base_id: cat4.id } });
    const existing5ta = await PlayerProfile.count({ where: { categoria_base_id: cat5.id } });
    
    console.log(`\nJugadores existentes:`);
    console.log(`4ta: ${existing4ta}`);
    console.log(`5ta: ${existing5ta}`);

    const nombres = [
      'Juan', 'Pedro', 'Carlos', 'Luis', 'Miguel', 'Jorge', 'Roberto', 'Fernando',
      'Diego', 'Javier', 'Andrés', 'Ricardo', 'Alberto', 'Sergio', 'Martín', 'Daniel',
      'Pablo', 'Alejandro', 'Gustavo', 'Raúl', 'Héctor', 'Oscar', 'Eduardo', 'Ramiro',
      'Facundo', 'Matías', 'Nicolás', 'Sebastián', 'Gonzalo', 'Maximiliano', 'Ignacio', 'Tomás',
      'Agustín', 'Ezequiel', 'Luciano', 'Rodrigo', 'Mariano', 'Cristian', 'Damián', 'Emiliano',
      'Leandro', 'Marcelo', 'Claudio', 'Gabriel', 'Adrián', 'Hernán', 'Walter', 'Rubén'
    ];

    const apellidos = [
      'González', 'Rodríguez', 'Fernández', 'López', 'Martínez', 'García', 'Pérez', 'Sánchez',
      'Romero', 'Torres', 'Díaz', 'Álvarez', 'Ruiz', 'Moreno', 'Jiménez', 'Muñoz',
      'Hernández', 'Castro', 'Vargas', 'Ramos', 'Silva', 'Mendoza', 'Ortiz', 'Navarro',
      'Cabrera', 'Medina', 'Ríos', 'Flores', 'Acosta', 'Benítez', 'Vega', 'Molina',
      'Pereyra', 'Suárez', 'Gutiérrez', 'Rojas', 'Domínguez', 'Giménez', 'Ramírez', 'Sosa',
      'Blanco', 'Luna', 'Ponce', 'Figueroa', 'Aguilar', 'Campos', 'Vera', 'Cardoso'
    ];

    let dniCounter = 30000013; // Continuar desde el último DNI usado
    const playersToCreate = [];

    // Crear 48 jugadores de 4ta
    console.log('\nCreando 48 jugadores de 4ta categoría...');
    for (let i = 0; i < 48; i++) {
      const nombre = nombres[i % nombres.length];
      const apellido = apellidos[Math.floor(i / nombres.length) % apellidos.length];
      const suffix = Math.floor(i / (nombres.length * apellidos.length)) + 1;
      
      playersToCreate.push({
        dni: String(dniCounter++),
        nombre: nombre,
        apellido: suffix > 1 ? `${apellido} ${suffix}` : apellido,
        telefono: `11${5000 + i}${6000 + i}`,
        categoria_base_id: cat4.id
      });
    }

    // Crear 48 jugadores de 5ta
    console.log('Creando 48 jugadores de 5ta categoría...');
    for (let i = 0; i < 48; i++) {
      const nombre = nombres[(i + 24) % nombres.length];
      const apellido = apellidos[Math.floor((i + 24) / nombres.length) % apellidos.length];
      const suffix = Math.floor((i + 24) / (nombres.length * apellidos.length)) + 1;
      
      playersToCreate.push({
        dni: String(dniCounter++),
        nombre: nombre,
        apellido: suffix > 1 ? `${apellido} ${suffix}` : apellido,
        telefono: `11${7000 + i}${8000 + i}`,
        categoria_base_id: cat5.id
      });
    }

    // Insertar todos los jugadores uno por uno
    console.log(`\nInsertando ${playersToCreate.length} jugadores...`);
    let created = 0;
    for (const player of playersToCreate) {
      try {
        await PlayerProfile.create(player);
        created++;
        if (created % 10 === 0) {
          console.log(`Creados ${created}/${playersToCreate.length}...`);
        }
      } catch (error) {
        console.error(`Error creando jugador ${player.dni}:`, error.message);
      }
    }

    console.log('\n✅ Jugadores creados exitosamente!');
    console.log(`Total creados: ${created}`);
    console.log(`DNI rango: 30000013 - ${dniCounter - 1}`);

    // Verificar totales
    const total4ta = await PlayerProfile.count({ where: { categoria_base_id: cat4.id } });
    const total5ta = await PlayerProfile.count({ where: { categoria_base_id: cat5.id } });
    
    console.log('\n📊 Totales en base de datos:');
    console.log(`Jugadores de 4ta: ${total4ta}`);
    console.log(`Jugadores de 5ta: ${total5ta}`);

    process.exit(0);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

createMorePlayers();
