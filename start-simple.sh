#!/bin/sh
# Script simple de inicio para Railway
echo "Starting Laravel application..."
PORT=${PORT:-8000}
php artisan migrate --force || true
exec php artisan serve --host=0.0.0.0 --port="$PORT"
