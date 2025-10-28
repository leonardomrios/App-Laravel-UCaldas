#!/bin/bash

# Build script para Railway
echo "🚀 Iniciando build de Laravel en Railway..."

# Configurar variables de entorno para build
export NODE_ENV=production
export APP_ENV=production

# Instalar dependencias PHP sin dev dependencies
echo "📦 Instalando dependencias PHP..."
composer install --optimize-autoloader --no-dev --no-scripts --no-interaction --prefer-dist

# Instalar dependencias Node.js
echo "📦 Instalando dependencias Node.js..."
npm ci --only=production

# Construir assets
echo "🏗️ Construyendo assets..."
npm run build

# Optimizar Laravel
echo "⚡ Optimizando Laravel..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "✅ Build completado!"