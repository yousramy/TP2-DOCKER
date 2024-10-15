#!/bin/bash

# Supprimer les conteneurs existants s'ils sont en cours d'exécution
docker rm -f http-container script-container data-container

# Construire l'image pour le conteneur PHP
docker build -t php-script -f Dockerfile .

# Lancer le conteneur de la base de données
docker run -d --name data-container \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -e MYSQL_DATABASE=testdb \
    -e MYSQL_USER=user \
    -e MYSQL_PASSWORD=password \
    -v ./db_data:/var/lib/mysql \
    -p 3306:3306 \
    mariadb:latest  

# Lancer le conteneur PHP en le liant à la base de données
docker run -d --name script-container \
    --link data-container:data \
    -v ./html:/var/www/html \
    php-script  

# Lancer le conteneur Nginx, en reliant à script-container
docker run -d --name http-container \
    -p 8081:80 \
    -v ./nginx.conf:/etc/nginx/nginx.conf \
    --link script-container:script \
    nginx:latest  

echo "Les conteneurs sont en cours d'exécution. Accédez à http://localhost:8081/test_bdd.php"
