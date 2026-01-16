# Sistema de Gestión de Torneos de Pádel

Sistema full-stack completo para la gestión de torneos de pádel con inscripción de jugadores, armado automático de zonas y cuadros de playoffs.

## Stack Tecnológico

### Backend
- Node.js + Express
- PostgreSQL
- Sequelize ORM
- JWT Authentication
- bcryptjs para encriptación

### Frontend
- React 18
- Vite
- Tailwind CSS
- React Router DOM
- Axios

### Deployment
- Docker + Docker Compose
- Nginx (reverse proxy y servidor estático)

## Características Principales

### Para Jugadores
- Registro con DNI y contraseña
- Creación de parejas (duplas)
- Inscripción a torneos por categoría
- Visualización de zonas, tablas de posiciones y playoffs
- Validación automática de categorías elegibles

### Para Administradores
- Gestión completa de categorías y torneos
- Configuración de formato de partidos por torneo/categoría
- Generación automática de zonas (round-robin)
- Carga de resultados con validación de formato
- Cálculo automático de tablas de posiciones
- Generación automática de playoffs con clasificados
- Avance automático de ganadores en playoffs

### Reglas de Negocio
- Identificación única por DNI
- Validación de categorías: jugador puede jugar su categoría base o máximo 1 categoría superior
- Parejas únicas (sin duplicados)
- Formatos de partido configurables: BEST_OF_3_SUPER_TB o BEST_OF_3_FULL
- Cálculo de standings con tie-breakers: puntos > diferencia sets > diferencia games > head-to-head

## Instalación y Configuración

### Requisitos Previos
- Node.js 18+
- PostgreSQL 15+ (o usar Docker)
- Docker y Docker Compose (para deployment)

### Desarrollo Local

#### 1. Clonar el repositorio
```bash
cd circuito_pm
```

#### 2. Configurar Backend

```bash
cd backend
npm install
```

Crear archivo `.env` en `backend/`:
```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=padel_user
DB_PASS=padel_pass
DB_NAME=padel_db
JWT_SECRET=tu-clave-secreta-muy-segura-cambiar-en-produccion
PORT=3000
NODE_ENV=development
```

#### 3. Configurar Base de Datos

Opción A - PostgreSQL local:
```bash
# Crear base de datos
createdb padel_db

# Ejecutar migraciones y seeds
npm run migrate
npm run seed
```

Opción B - PostgreSQL con Docker:
```bash
docker run -d \
  --name padel_postgres \
  -e POSTGRES_USER=padel_user \
  -e POSTGRES_PASSWORD=padel_pass \
  -e POSTGRES_DB=padel_db \
  -p 5432:5432 \
  postgres:15-alpine
```

#### 4. Iniciar Backend
```bash
npm run dev
# Backend corriendo en http://localhost:3000
```

#### 5. Configurar Frontend

```bash
cd ../frontend
npm install
```

Crear archivo `.env` en `frontend/` (opcional):
```env
VITE_API_URL=http://localhost:3000
```

#### 6. Iniciar Frontend
```bash
npm run dev
# Frontend corriendo en http://localhost:5173
```

### Credenciales por Defecto

**Administrador:**
- DNI: `admin`
- Contraseña: `admin123`

**Categorías creadas automáticamente:**
- 1ra (rank 1) - más alta
- 2da (rank 2)
- 3ra (rank 3)
- 4ta (rank 4)
- 5ta (rank 5)
- 6ta (rank 6)
- 7ma (rank 7)
- 8va (rank 8) - más baja

## Deployment en VPS con Docker

### 1. Preparar el Servidor

```bash
# Instalar Docker y Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 2. Clonar el Proyecto en el VPS

```bash
git clone <tu-repositorio> circuito_pm
cd circuito_pm
```

### 3. Configurar Variables de Entorno

Crear archivo `.env` en la raíz del proyecto:
```env
DB_HOST=postgres
DB_PORT=5432
DB_USER=padel_user
DB_PASS=TU_PASSWORD_SEGURO_AQUI
DB_NAME=padel_db
JWT_SECRET=TU_JWT_SECRET_MUY_SEGURO_CAMBIAR_ESTO
PORT=3000
NODE_ENV=production
```

**IMPORTANTE:** Cambiar `DB_PASS` y `JWT_SECRET` por valores seguros en producción.

### 4. Build y Deploy

```bash
# Build y levantar todos los servicios
docker-compose up -d --build

# Ver logs
docker-compose logs -f

# Verificar que los contenedores estén corriendo
docker-compose ps
```

### 5. Acceder a la Aplicación

La aplicación estará disponible en:
- **Frontend:** `http://tu-servidor-ip` (puerto 80)
- **Backend API:** `http://tu-servidor-ip/api`

### 6. Comandos Útiles

```bash
# Detener servicios
docker-compose down

# Reiniciar servicios
docker-compose restart

# Ver logs de un servicio específico
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f postgres

# Ejecutar migraciones manualmente
docker-compose exec backend npm run migrate

# Ejecutar seeds manualmente
docker-compose exec backend npm run seed

# Backup de base de datos
docker-compose exec postgres pg_dump -U padel_user padel_db > backup.sql

# Restaurar base de datos
docker-compose exec -T postgres psql -U padel_user padel_db < backup.sql

# Limpiar todo (CUIDADO: elimina datos)
docker-compose down -v
```

## Estructura del Proyecto

```
circuito_pm/
├── backend/
│   ├── src/
│   │   ├── config/          # Configuración de DB
│   │   ├── models/          # Modelos Sequelize
│   │   ├── controllers/     # Controladores de rutas
│   │   ├── services/        # Lógica de negocio (zonas, brackets)
│   │   ├── middleware/      # Auth middleware
│   │   ├── routes/          # Definición de rutas
│   │   ├── utils/           # Utilidades y validaciones
│   │   ├── scripts/         # Scripts de migración y seed
│   │   └── server.js        # Punto de entrada
│   ├── Dockerfile
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── components/      # Componentes reutilizables
│   │   │   ├── admin/       # Componentes admin
│   │   │   ├── Modal.jsx
│   │   │   └── Toast.jsx
│   │   ├── context/         # Context API (Auth)
│   │   ├── pages/           # Páginas principales
│   │   ├── services/        # API client
│   │   ├── App.jsx
│   │   └── main.jsx
│   ├── Dockerfile
│   ├── nginx.conf
│   └── package.json
├── docker-compose.yml
├── .env.example
└── README.md
```

## API Endpoints

### Autenticación
- `POST /api/auth/register` - Registro de jugador
- `POST /api/auth/login` - Login
- `GET /api/auth/me` - Obtener usuario actual

### Jugadores
- `GET /api/categories` - Listar categorías
- `POST /api/teams` - Crear pareja
- `GET /api/teams/me` - Mis parejas
- `POST /api/registrations` - Inscribirse a torneo
- `GET /api/registrations/me` - Mis inscripciones

### Torneos (Público)
- `GET /api/tournaments` - Listar torneos
- `GET /api/tournaments/:id` - Detalle de torneo
- `GET /api/tournament-categories/zones` - Ver zonas
- `GET /api/tournament-categories/standings` - Ver tabla de posiciones
- `GET /api/tournament-categories/zone-matches` - Ver partidos de zona
- `GET /api/tournament-categories/playoffs` - Ver playoffs

### Admin
- `POST /api/admin/categories` - Crear categoría
- `PUT /api/admin/categories/:id` - Actualizar categoría
- `DELETE /api/admin/categories/:id` - Desactivar categoría
- `POST /api/admin/tournaments` - Crear torneo
- `PUT /api/admin/tournaments/:id` - Actualizar torneo
- `DELETE /api/admin/tournaments/:id` - Eliminar torneo
- `POST /api/admin/tournament-categories` - Agregar categoría a torneo
- `GET /api/admin/registrations` - Ver inscripciones
- `POST /api/admin/zones/generate` - Generar zonas
- `PATCH /api/admin/zone-matches/:id/result` - Cargar resultado de zona
- `POST /api/admin/playoffs/generate` - Generar playoffs
- `PATCH /api/admin/matches/:id/result` - Cargar resultado de playoff
- `PATCH /api/admin/matches/:id/schedule` - Programar partido

## Flujo de Uso Completo

### 1. Configuración Inicial (Admin)
1. Login como admin
2. Crear/verificar categorías (1ra a 8va)
3. Crear torneo
4. Agregar categorías al torneo con configuración:
   - Formato de partido (BEST_OF_3_SUPER_TB o BEST_OF_3_FULL)
   - Puntos por victoria/derrota
   - Cupo (opcional)
   - Inscripción abierta/cerrada

### 2. Inscripción (Jugadores)
1. Registro con DNI, nombre, apellido, categoría base
2. Crear pareja con DNI del compañero
3. Inscribirse a torneo en categoría permitida

### 3. Fase de Zonas (Admin)
1. Cerrar inscripciones
2. Generar zonas (definir tamaño y clasificados por zona)
3. Cargar resultados de partidos de zona
4. Sistema calcula automáticamente tabla de posiciones

### 4. Fase de Playoffs (Admin)
1. Generar playoffs con clasificados
2. Sistema crea cuadro automático con BYEs si es necesario
3. Cargar resultados de partidos
4. Ganadores avanzan automáticamente
5. Determinar campeón

## Validaciones Implementadas

### Categorías
- Jugador solo puede jugar su categoría base o 1 superior
- Ejemplo: categoría base 5ta (rank=5) puede jugar 5ta o 4ta (rank=4)

### Resultados
- **BEST_OF_3_SUPER_TB:** 2 sets normales + super tie-break a 10 si empate 1-1
- **BEST_OF_3_FULL:** 3 sets normales completos
- Validación de sets ganadores (6-4, 7-5, 7-6, etc.)
- Super tie-break debe llegar a 10 con diferencia de 2

### Inscripciones
- Pareja no puede inscribirse dos veces en misma categoría
- Validación de cupo si está configurado
- Inscripción debe estar abierta

## Troubleshooting

### Backend no conecta a DB
```bash
# Verificar que PostgreSQL esté corriendo
docker-compose ps postgres

# Ver logs de PostgreSQL
docker-compose logs postgres

# Verificar variables de entorno
docker-compose exec backend env | grep DB_
```

### Frontend no carga
```bash
# Verificar que Nginx esté corriendo
docker-compose ps frontend

# Ver logs
docker-compose logs frontend

# Rebuild frontend
docker-compose up -d --build frontend
```

### Error de CORS
- Verificar que el backend esté configurado con CORS habilitado
- En producción, el frontend hace proxy de `/api` al backend

### Error de autenticación
- Verificar que JWT_SECRET esté configurado
- Verificar que el token no haya expirado (7 días por defecto)

## Seguridad en Producción

1. **Cambiar credenciales por defecto:**
   - Cambiar contraseña de admin
   - Usar contraseñas fuertes para DB

2. **Variables de entorno:**
   - Nunca commitear archivos `.env`
   - Usar JWT_SECRET único y seguro

3. **HTTPS:**
   - Configurar certificado SSL (Let's Encrypt)
   - Usar Nginx como reverse proxy con SSL

4. **Firewall:**
   - Abrir solo puertos necesarios (80, 443)
   - Cerrar puerto 5432 (PostgreSQL) al exterior

5. **Backups:**
   - Configurar backups automáticos de PostgreSQL
   - Guardar backups en ubicación segura

## Soporte y Contribuciones

Para reportar bugs o solicitar features, crear un issue en el repositorio.

## Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.
