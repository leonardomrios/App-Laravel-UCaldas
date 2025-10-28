#!/bin/bash

# Script específico para Railway que maneja el problema de Rollup
set -e

echo "🚀 Iniciando build optimizado para Railway..."

# Instalar dependencias PHP
echo "📦 Instalando dependencias PHP..."
composer install --optimize-autoloader --no-dev --no-scripts --no-interaction

# Limpiar completamente npm
echo "🧹 Limpiando npm y node_modules..."
npm cache clean --force || true
rm -rf node_modules package-lock.json || true

# Configurar npm para Linux
echo "⚙️ Configurando npm para Linux x64..."
npm config set target_platform linux
npm config set target_arch x64

# Instalar dependencias con manejo específico de Rollup
echo "📦 Instalando dependencias Node.js..."
npm install --legacy-peer-deps --no-audit --no-fund --include=optional

# Instalar específicamente el binario de Rollup para Linux
echo "🔧 Instalando binario Rollup para Linux..."
npm install @rollup/rollup-linux-x64-gnu --save-optional --legacy-peer-deps || echo "⚠️ Rollup binary install failed, continuing..."

# Verificar que Rollup funciona
echo "🔍 Verificando Rollup..."
node -e "try { require('@rollup/rollup-linux-x64-gnu'); console.log('✅ Rollup binary OK'); } catch(e) { console.log('⚠️ Rollup binary missing, trying fallback'); }"

# Build con manejo de errores
echo "🏗️ Construyendo assets..."
npm run build

echo "✅ Build completado exitosamente!"