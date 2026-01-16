# Guía de Migración al VPS con Docker

Sigue estos pasos para subir y ejecutar tu aplicación en un servidor VPS.

## 1. Prerrequisitos en el VPS

Asegúrate de tener instalado **Docker** y **Docker Compose** en tu servidor.
```bash
# Ejemplo para Ubuntu
sudo apt update
sudo apt install docker.io docker-compose -y
```

## 2. Archivos Necesarios

Debes subir los siguientes archivos y carpetas a tu VPS:
- `backend/` (código fuente del backend)
- `frontend/` (código fuente del frontend)
- `docker-compose.yml`
- `full_backup.sql` (Base de datos completa)

Puedes usar `scp` o FileZilla para transferirlos.

## 3. Configuración

El archivo `docker-compose.yml` ya está configurado para:
- Crear una base de datos PostgreSQL e importar automáticamente tu backup (`full_backup.sql`).
- Levantar el backend en el puerto 3000.
- Compilar y servir el frontend en el puerto 80 (HTTP estándar).

Si necesitas cambiar contraseñas, edita el archivo `docker-compose.yml`.

## 4. Iniciar la Aplicación

Navega a la carpeta donde subiste los archivos y ejecuta:

```bash
# Construir y levantar los servicios en segundo plano
sudo docker-compose up -d --build
```

## 5. Verificar

- **Frontend**: Accede a `http://TU_IP_DEL_VPS`
- **Backend**: `http://TU_IP_DEL_VPS/api/...`
- **Base de Datos**: Se ejecuta internamente.

Si necesitas ver logs:
```bash
sudo docker-compose logs -f
```

## Notas Importantes
- La base de datos persistirá su información en un volumen de Docker llamado `postgres_data`.
- El backup `full_backup.sql` solo se importa la **primera vez** que se crea el contenedor de la base de datos. Si necesitas re-importarlo, debes borrar el volumen: `sudo docker volume rm circuito_pm_postgres_data`.
