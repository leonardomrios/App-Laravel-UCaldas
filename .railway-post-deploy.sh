# Railway Post-Deploy Hook
# Este archivo se ejecuta después del build

echo "🔧 Ejecutando configuración post-deploy..."

# Ejecutar migraciones
php artisan migrate --force

echo "✅ Configuración completada"
