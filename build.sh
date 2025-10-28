#!/bin/bash

# Build script para Railway
echo "🚀 Iniciando build de Laravel en Railway..."

# Configurar variables de entorno para build
export NODE_ENV=production
export APP_ENV=production

# Instalar dependencias PHP sin dev dependencies
echo "📦 Instalando dependencias PHP..."
composer install --optimize-autoloader --no-dev --no-scripts --no-interaction --prefer-dist

# Limpiar npm cache y reinstalar dependencias
echo "🧹 Limpiando cache de npm..."
npm cache clean --force || true
rm -rf node_modules package-lock.json || true

echo "📦 Instalando dependencias Node.js..."
npm install --legacy-peer-deps --no-audit --no-fund

# Construir assets
echo "🏗️ Construyendo assets..."
npm run build

# Optimizar Laravel
echo "⚡ Optimizando Laravel..."
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

echo "✅ Build completado!"