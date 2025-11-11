# Configuración de Railway - App Laravel UCaldas

## 🔧 Variables de Entorno Requeridas

### 1. Generar APP_KEY (ejecuta localmente y copia el resultado):
```bash
php artisan key:generate --show
```

### 2. Variables OBLIGATORIAS en Railway:

```env
# Aplicación
APP_NAME="App Laravel UCaldas"
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:TU_CLAVE_GENERADA_AQUI
APP_URL=https://tu-dominio.up.railway.app

# Localization
APP_LOCALE=es
APP_FALLBACK_LOCALE=en
APP_TIMEZONE=America/Bogota

# Database (Railway provee automáticamente si agregas PostgreSQL)
DB_CONNECTION=pgsql
DB_HOST=${{Postgres.PGHOST}}
DB_PORT=${{Postgres.PGPORT}}
DB_DATABASE=${{Postgres.PGDATABASE}}
DB_USERNAME=${{Postgres.PGUSER}}
DB_PASSWORD=${{Postgres.PGPASSWORD}}

# Session
SESSION_DRIVER=database
SESSION_LIFETIME=120

# Cache
CACHE_STORE=database

# Queue
QUEUE_CONNECTION=database

# Logging
LOG_CHANNEL=stack
LOG_LEVEL=error

# Mail (opcional)
MAIL_MAILER=log

# Jetstream Features
FORTIFY_FEATURES=registration,reset-passwords,email-verification,update-profile-information,update-passwords,two-factor-authentication,delete-account
JETSTREAM_FEATURES=account-deletion,api,teams
```

## 🗄️ Base de Datos

### Opción 1: PostgreSQL (Recomendado para Railway)
1. En Railway, click en tu proyecto
2. Click en "New" → "Database" → "Add PostgreSQL"
3. Railway configurará automáticamente las variables `${{Postgres.*}}`
4. Usa las variables como se muestra arriba

### Opción 2: SQLite (solo para pruebas)
```env
DB_CONNECTION=sqlite
DB_DATABASE=/app/storage/database.sqlite
```

## 🌐 Puerto

Railway asigna automáticamente la variable `$PORT`. 
**NO necesitas configurar PORT manualmente.**

El Procfile ya está configurado para usar `$PORT` automáticamente.

## 📋 Pasos de Configuración en Railway

### 1. Crear el servicio
```bash
# Conecta tu repositorio GitHub
- Ve a Railway.app
- New Project → Deploy from GitHub repo
- Selecciona: leonardomrios/App-Laravel-UCaldas
```

### 2. Configurar Variables de Entorno
```bash
# En Railway dashboard:
Settings → Variables → RAW Editor

# Pega las variables (ajusta APP_KEY y APP_URL):
APP_NAME=App Laravel UCaldas
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:TU_CLAVE_AQUI
APP_URL=https://tu-dominio.up.railway.app
APP_LOCALE=es
APP_TIMEZONE=America/Bogota
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database
LOG_LEVEL=error
```

### 3. Agregar Base de Datos PostgreSQL
```bash
# En Railway:
- Click en "New"
- Selecciona "Database"
- Elige "PostgreSQL"
- Railway conectará automáticamente
```

### 4. Configurar el Dominio
```bash
# En Railway:
- Settings → Networking → Generate Domain
- Copia el dominio generado
- Actualiza APP_URL con ese dominio
```

### 5. Forzar Redeploy
```bash
# Después de configurar variables:
- Deployments → tres puntos → Redeploy
```

## ⚡ Comandos Útiles (ejecutar desde Railway CLI o local)

### Generar APP_KEY
```bash
php artisan key:generate --show
```

### Ver rutas configuradas
```bash
php artisan route:list
```

### Limpiar caches
```bash
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear
```

## 🔍 Troubleshooting

### Error: "Unsupported operand types: string + int"
**Solución**: Railway está enviando PORT como string. Actualizado en el Procfile.

### Error: "No application encryption key"
**Solución**: Configura APP_KEY (usa `php artisan key:generate --show`)

### Error: Database connection failed
**Solución**: 
1. Verifica que PostgreSQL esté agregado
2. Verifica las variables DB_* están configuradas
3. Railway provee automáticamente: `${{Postgres.VARIABLE}}`

### Error: 500 Internal Server Error
**Solución**:
1. Configura `APP_DEBUG=true` temporalmente
2. Revisa logs en Railway: View Logs
3. Verifica APP_KEY está configurado

## 📝 Notas Importantes

1. **APP_KEY**: DEBE ser generado con `php artisan key:generate --show`
2. **APP_URL**: DEBE coincidir con tu dominio de Railway
3. **DB_CONNECTION**: Usa `pgsql` para PostgreSQL (recomendado)
4. **LOG_LEVEL**: `error` en producción para reducir logs
5. **APP_DEBUG**: SIEMPRE `false` en producción (por seguridad)

## 🚀 Verificación Post-Deploy

### 1. Verifica que el servicio está corriendo:
- Ve a la URL de Railway
- Deberías ver la página de bienvenida de Laravel

### 2. Prueba el login:
- Ve a `/login`
- Deberías poder registrarte y acceder

### 3. Revisa los logs:
```bash
# En Railway dashboard:
View Logs
```

## 📧 Soporte

Si tienes problemas:
1. Revisa los logs de Railway
2. Verifica que todas las variables estén configuradas
3. Asegúrate de que PostgreSQL esté conectado
4. Intenta redeploy después de cambios
