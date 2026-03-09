# AGENTS.md - Guía para Agentes de Código

Sistema full-stack para gestión de torneos de pádel.

## Stack
- **Backend:** Node.js + Express, PostgreSQL, Sequelize ORM, JWT
- **Frontend:** React 18, Vite, Tailwind CSS, React Router DOM, Axios
- **Deployment:** Docker + Docker Compose

## Comandos

### Backend
```bash
cd backend && npm install
npm run dev        # desarrollo
npm start          # producción
npm run migrate    # migraciones
npm run seed       # datos iniciales
npm run setup      # migrate + seed
```

### Frontend
```bash
cd frontend && npm install
npm run dev        # desarrollo
npm run build      # producción
npm run preview    # preview build
```

### Docker
```bash
docker-compose up -d --build
docker-compose logs -f
docker-compose down
docker-compose exec backend npm run migrate
```

## Estructura

```
backend/src/{ config/, models/, controllers/, services/, middleware/, routes/, utils/, scripts/, server.js }
frontend/src/{ components/, context/, pages/, services/, utils/ }
```

## Convenciones - Backend

### Estilo: CommonJS, 2 espacios, punto y coma sí

### Imports (orden exacto)
```javascript
// 1. Externos
const express = require('express');
// 2. Internos
const { User } = require('../models');
// 3. Locales
const { validate } = require('../utils/validation');
```

### Nombres
- Archivos: `camelCase` (`authController.js`)
- Funciones: `camelCase` (`generateZones`)
- Modelos: `PascalCase` (`User`, `TournamentCategory`)
- Constantes: `UPPER_SNAKE_CASE` (`MAX_ZONE_SIZE`)

### Rutas
```javascript
router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', authMiddleware, controller.create);
router.put('/:id', authMiddleware, controller.update);
router.delete('/:id', authMiddleware, adminMiddleware, controller.delete);
```

### Error Handling
```javascript
res.status(500).json({ ok: false, error: { code: 'SERVER_ERROR', message: 'Mensaje' } });
res.status(404).json({ ok: false, error: { code: 'NOT_FOUND', message: 'No encontrado' } });
res.status(400).json({ ok: false, error: { code: 'VALIDATION_ERROR', message: 'Error' } });
```

### Modelo Sequelize
```javascript
module.exports = (sequelize, DataTypes) => {
  const Model = sequelize.define('ModelName', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING, allowNull: false }
  }, { tableName: 'table_name', timestamps: true, underscored: true });
  Model.associate = (models) => {
    Model.belongsTo(models.Other, { foreignKey: 'other_id', as: 'other' });
  };
  return Model;
};
```

## Convenciones - Frontend

### Estilo: ES6, JSX, 2 espacios

### Imports (orden exacto)
```javascript
import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import Button from '../components/Button'
import api from '../services/api'
import { formatDate } from '../utils/helpers'
```

### Componente
```javascript
export default function ComponentName({ prop1, prop2 = 'default', onAction, className = '' }) {
  const [state, setState] = useState(initialValue)
  return <div className={`base ${className}`}>{/* JSX */}</div>
}
```

### Nombres
- Componentes: `PascalCase` (`AdminTournament.jsx`)
- Utils: `camelCase` (`helpers.js`)

## Variables de Entorno

### Backend
```env
DB_HOST=localhost DB_PORT=5432 DB_USER=padel_user DB_PASS=padel_pass
DB_NAME=padel_db JWT_SECRET=secret PORT=3000 NODE_ENV=development
```

### Frontend
```env
VITE_API_URL=http://localhost:3000
```

## Credenciales
- Admin: DNI `admin`, pass `admin123`
- Categorías: 1ra a 8va (rank 1-8)

## Reglas de Negocio
1. Categoría: jugador puede jugar su base o máx 1 superior
2. Parejas: un jugador no puede estar en dos activas
3. Formatos: `BEST_OF_3_SUPER_TB` o `BEST_OF_3_FULL`

## API Response
```javascript
{ ok: true, data: { ... } }
{ ok: true, message: 'Operación exitosa' }
{ ok: false, error: { code: 'ERROR', message: 'msg' } }
```

## Notas
- No hay tests configurados, no hay linter
- Mensajes de usuario en español
- Fechas en ISO
- JWT expira en 7 días
- Rutas admin con `adminMiddleware`
