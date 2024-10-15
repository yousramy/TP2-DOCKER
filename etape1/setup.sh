#!/bin/bash

# Supprimer les conteneurs existants s'ils sont en cours d'exécution
docker rm -f http-container script-container data-container

# Construire l'image pour le conteneur PHP
docker build -t php-script -f Dockerfile-script .

# Construire l'image pour le conteneur Nginx
docker build -t nginx-http -f Dockerfile-http .

# Lancer le conteneur PHP
docker run -d --name script-container php-script

# Lancer le conteneur Nginx, en reliant à script-container
docker run -d --name http-container -p 8080:8080 --link script-container:script nginx-http

echo "Les conteneurs sont en cours d'exécution. Accédez à http://localhost:8080"
