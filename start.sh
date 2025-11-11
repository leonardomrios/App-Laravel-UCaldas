#!/bin/bash

# Script de inicio para Railway con debug
set -e

echo "========================================="
echo "🚀 Iniciando aplicación Laravel..."
echo "========================================="

# Verificar variables de entorno críticas
echo "🔍 Verificando configuración..."
echo "APP_ENV: ${APP_ENV:-not_set}"
echo "DB_CONNECTION: ${DB_CONNECTION:-not_set}"
echo "DB_HOST: ${DB_HOST:-not_set}"

# Asegurar que PORT es un número
PORT=${PORT:-8000}
PORT=$(echo "$PORT" | tr -d '"' | tr -d "'")
echo "📡 Puerto configurado: $PORT"

# Crear directorio de base de datos SQLite si es necesario
if [ "$DB_CONNECTION" = "sqlite" ]; then
    echo "📁 Configurando SQLite..."
    mkdir -p /app/storage/database
    touch /app/storage/database/database.sqlite
fi

# Ejecutar migraciones
echo "🗄️ Ejecutando migraciones..."
php artisan migrate --force 2>&1 || echo "⚠️ Migraciones omitidas o fallaron"

# Verificar conexión a base de datos
echo "🔌 Verificando conexión a base de datos..."
php artisan db:show 2>&1 || echo "⚠️ No se pudo verificar la conexión DB"

# Limpiar caches
echo "🧹 Limpiando caches..."
php artisan config:clear 2>&1 || true
php artisan cache:clear 2>&1 || true

# Iniciar servidor
echo "========================================="
echo "✅ Iniciando servidor en 0.0.0.0:$PORT"
echo "========================================="
php artisan serve --host=0.0.0.0 --port="$PORT"
