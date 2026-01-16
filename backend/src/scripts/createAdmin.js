const bcrypt = require('bcryptjs');
const { User, PlayerProfile, Category } = require('../models');

async function createAdmin() {
  try {
    console.log('Creando usuario administrador...');

    const dni = '35702164';
    const password = '35702';

    const existingUser = await User.findOne({ where: { dni } });
    
    if (existingUser) {
      console.log(`Usuario con DNI ${dni} ya existe.`);
      console.log(`Rol actual: ${existingUser.role}`);
      
      if (existingUser.role !== 'admin') {
        existingUser.role = 'admin';
        await existingUser.save();
        console.log('✅ Usuario actualizado a rol admin');
      } else {
        console.log('✅ El usuario ya es administrador');
      }
    } else {
      const password_hash = await bcrypt.hash(password, 10);
      
      await User.create({
        dni,
        password_hash,
        role: 'admin'
      });

      console.log('✅ Usuario administrador creado exitosamente');
      console.log(`   DNI: ${dni}`);
      console.log(`   Contraseña: ${password}`);
      console.log(`   Rol: admin`);
    }

    console.log('\n✅ Proceso completado.');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error al crear administrador:', error);
    process.exit(1);
  }
}

createAdmin();
