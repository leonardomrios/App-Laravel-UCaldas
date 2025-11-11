#!/bin/bash

# Script de inicio para Railway
set -e

echo "🚀 Iniciando aplicación Laravel..."

# Asegurar que PORT es un número
PORT=${PORT:-8000}
PORT=$(echo "$PORT" | tr -d '"' | tr -d "'")

echo "📡 Puerto configurado: $PORT"

# Ejecutar migraciones si es necesario
php artisan migrate --force || echo "⚠️ Migraciones omitidas"

# Iniciar servidor
php artisan serve --host=0.0.0.0 --port="$PORT"
