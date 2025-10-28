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
    ca-certificates \
    gnupg

# Install Node.js 20 (más estable para Rollup)
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y nodejs

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
RUN npm config set cache /tmp/.npm --global && \
    npm config set audit false --global && \
    npm config set fund false --global && \
    npm config set optional false --global

# Clean any existing installations
RUN rm -rf node_modules package-lock.json || true

# Install npm dependencies with explicit rollup binaries
RUN npm install --legacy-peer-deps --no-audit --no-fund --no-optional && \
    npm install @rollup/rollup-linux-x64-gnu --save-optional --legacy-peer-deps

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