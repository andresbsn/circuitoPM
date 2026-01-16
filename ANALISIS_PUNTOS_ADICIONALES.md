# Análisis de Puntos Adicionales (6-11)

## Estado Actual vs Requerimientos

### 6. Modelo de Score Robusto

**Estado Actual:**
- ✅ Usa `score_json` como fuente de verdad
- ✅ Deriva `winner_team_id` automáticamente
- ✅ Validación de SUPER_TB solo en 3er set
- ✅ Validación de diferencia de 2 en TB
- ⚠️ **FALTA**: Validar que no se cargue SUPER_TB si formato es FULL
- ⚠️ **FALTA**: Validar que no se cargue 3er set si ya se definió en 2

**Código Actual (validation.js líneas 113-158):**
```javascript
// BEST_OF_3_SUPER_TB
if (sets.length === 2 && homeSets === awaySets) {
  return { valid: false, error: 'Si hay empate 1-1, debe jugarse el super tie-break' };
}
```

**Problemas Detectados:**
1. ❌ Permite cargar SUPER_TB en formato FULL (no valida `set.type`)
2. ❌ Permite cargar 3 sets cuando partido ya está 2-0

---

### 7. Integridad de Pareja (Team)

**Estado Actual:**
- ✅ Unique constraint con LEAST/GREATEST (líneas 28-35 Team.js)
- ✅ Validación de mismo jugador (línea 19-27 teamController.js)
- ❌ **FALTA**: Validar que jugador no esté en 2 parejas activas simultáneamente

**Código Actual:**
```javascript
// Team.js - Unique constraint OK
indexes: [{
  unique: true,
  fields: [
    sequelize.fn('LEAST', sequelize.col('player1_dni'), sequelize.col('player2_dni')),
    sequelize.fn('GREATEST', sequelize.col('player1_dni'), sequelize.col('player2_dni'))
  ]
}]

// teamController.js - Valida mismo jugador OK
if (companion_dni === currentUserDni) {
  return res.status(400).json({...});
}
```

**Problema Detectado:**
- ❌ Un jugador puede estar en múltiples parejas activas (con diferentes compañeros)
- Ejemplo: Jugador A puede tener pareja con B (activa) y pareja con C (activa)

---

### 8. Validación de Categoría "Una por Encima"

**Estado Actual:**
- ✅ Valida ambos jugadores de la pareja (líneas 33-56 validation.js)
- ⚠️ **PROBLEMA**: Lógica de rank está INVERTIDA

**Código Actual (línea 23):**
```javascript
if (tournamentRank < baseRank - 1 || tournamentRank > baseRank) {
  return { valid: false, error: '...' };
}
```

**Análisis:**
- Si 1ra = rank 1 (más alta), 8va = rank 8 (más baja)
- Jugador base rank=8 (8va) debería poder jugar rank 8 o 7 (8va o 7ma)
- Regla correcta: `tournamentRank >= baseRank - 1 && tournamentRank <= baseRank`
- **PERO** la lógica actual está al revés

**Ejemplo con código actual:**
- Jugador base rank=8 (8va)
- Torneo rank=8 (8va): `8 < 7 || 8 > 8` → FALSE → ✅ PERMITE (OK)
- Torneo rank=7 (7ma): `7 < 7 || 7 > 8` → FALSE → ✅ PERMITE (OK)
- Torneo rank=6 (6ta): `6 < 7 || 6 > 8` → TRUE → ❌ RECHAZA (OK)

**Conclusión:** ✅ La lógica está CORRECTA (permite base o 1 superior)

---

### 9. Generación de Fixture Round-Robin

**Estado Actual:**
- ✅ Usa "circle method" (líneas 24-61 zoneService.js)
- ✅ Maneja N impar agregando null (BYE)
- ✅ Genera rondas ordenadas

**Código Actual:**
```javascript
function generateRoundRobinFixture(teams) {
  const teamsCopy = [...teams];
  
  if (n % 2 === 1) {
    teamsCopy.push(null); // BYE
  }
  
  // Circle method implementation
  for (let round = 0; round < rounds; round++) {
    // ... rotación correcta
  }
}
```

**Conclusión:** ✅ YA ESTÁ BIEN IMPLEMENTADO

---

### 10. Playoffs: Mapeo de Clasificados Estable

**Estado Actual:**
- ✅ Modelo Match tiene campos de trazabilidad (Match.js):
  - `home_source_zone_id`
  - `home_source_position`
  - `away_source_zone_id`
  - `away_source_position`
- ❌ **FALTA**: Guardar estos valores al generar playoffs

**Código Actual (bracketService.js):**
```javascript
// NO guarda source_zone_id ni source_position
await Match.create({
  bracket_id: bracket.id,
  round_number: currentRound,
  // ... FALTA home_source_zone_id, home_source_position, etc.
}, { transaction });
```

**Problema:**
- Los campos existen en el modelo pero no se populan
- No hay trazabilidad de dónde viene cada equipo

---

### 11. Concurrencia: Doble Carga de Resultados

**Estado Actual:**
- ❌ **NO HAY VALIDACIÓN** de status antes de actualizar
- ❌ No hay optimistic locking

**Código Actual (adminController.js línea 353-415):**
```javascript
exports.updateZoneMatchResult = async (req, res) => {
  const match = await ZoneMatch.findByPk(id);
  
  // NO VALIDA si match.status === 'played'
  
  match.score_json = score_json;
  match.status = 'played';
  await match.save({ transaction });
}
```

**Problema:**
- Dos admins pueden cargar resultados diferentes simultáneamente
- El último en guardar sobrescribe al primero sin advertencia

---

## Resumen de Mejoras Necesarias

### 🔴 CRÍTICO
1. **Punto 6**: Mejorar validación de score (no SUPER_TB en FULL, no 3er set si 2-0)
2. **Punto 11**: Validar concurrencia en carga de resultados

### 🟡 IMPORTANTE
3. **Punto 7**: Validar que jugador no esté en múltiples parejas activas
4. **Punto 10**: Guardar source_zone_id y source_position en playoffs

### 🟢 YA IMPLEMENTADO CORRECTAMENTE
5. **Punto 8**: Validación de categoría ✅
6. **Punto 9**: Round-robin fixture ✅

---

## Recomendación

**Implementar mejoras en este orden:**
1. Punto 6 (score robusto) - 15 min
2. Punto 11 (concurrencia) - 10 min
3. Punto 7 (parejas únicas) - 20 min
4. Punto 10 (trazabilidad playoffs) - 15 min

**Total estimado: ~60 minutos**
