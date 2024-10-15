FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
