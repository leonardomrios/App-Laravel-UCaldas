FROM php:8.2-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nodejs \
    npm

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy composer files
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --optimize-autoloader --no-dev --no-scripts --no-interaction

# Copy package.json files
COPY package.json package-lock.json ./

# Configure npm
RUN npm config set cache /tmp/.npm --global
RUN npm config set audit false --global
RUN npm config set fund false --global

# Install npm dependencies
RUN npm ci --legacy-peer-deps --no-audit --no-fund

# Copy application code
COPY . .

# Build assets
RUN npm run build

# Optimize Laravel
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

EXPOSE $PORT

CMD php artisan serve --host=0.0.0.0 --port=$PORT