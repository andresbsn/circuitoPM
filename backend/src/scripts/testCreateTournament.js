const { Tournament } = require('../models');
const { TOURNAMENT_STATES } = require('../utils/constants');

async function testCreateTournament() {
  try {
    console.log('Probando creación de torneo...');
    console.log('TOURNAMENT_STATES:', TOURNAMENT_STATES);

    const tournament = await Tournament.create({
      nombre: 'Torneo de Prueba',
      fecha_inicio: new Date('2026-02-01'),
      fecha_fin: new Date('2026-02-28'),
      descripcion: 'Torneo de prueba para verificar funcionalidad',
      estado: TOURNAMENT_STATES.DRAFT
    });

    console.log('✅ Torneo creado exitosamente:');
    console.log(JSON.stringify(tournament.toJSON(), null, 2));
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error al crear torneo:');
    console.error('Mensaje:', error.message);
    console.error('Stack:', error.stack);
    process.exit(1);
  }
}

testCreateTournament();
