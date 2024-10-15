#!/bin/bash

# Construire l'image Docker pour PHP avec l'extension mysqli
echo "Building PHP Docker image..."
docker build -t custom-php .

# Lancer le conteneur de base de données MariaDB
echo "Starting MariaDB container..."
docker run --name data-container \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=password \
  -v ./db_data:/var/lib/mysql \
  -p 3306:3306 \
  -d mariadb:latest

# Lancer le conteneur PHP
echo "Starting PHP container..."
docker run --name script-container \
  -v $(pwd)/html:/var/www/html \
  --link data-container:data-container \
  -d custom-php

# Lancer le conteneur Nginx
echo "Starting Nginx container..."
docker run --name http-container \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
  -p 8083:80 \
  --link script-container:script-container \
  -d nginx

echo "Displaying running containers..."
docker ps

echo "Displaying Nginx logs..."
docker logs http-container
