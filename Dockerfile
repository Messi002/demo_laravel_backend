FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    libgrpc-dev \
    libprotobuf-dev \
    protobuf-compiler \
    unzip \
    git \
    curl \
    && pecl install grpc \
    && docker-php-ext-enable grpc \
    && docker-php-ext-install pdo_mysql pdo_pgsql pdo_sqlite gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader

COPY . .

RUN composer dump-autoload --optimize

EXPOSE 9000
CMD ["php-fpm"]
