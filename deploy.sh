#!/bin/bash

if [ -f .env ]; then
    set -a         
    source .env
    set +a
else
    echo ".env file not found!"
    exit 1
fi

#volumes
docker volume create db_data
docker volume create wp_data

#networks
docker network create backend-net
docker network create frontend-net

#Mariadb
docker run -d --name db \
    --restart always \
    --network backend-net \
    -v db_data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    -e MYSQL_DATABASE=$MYSQL_DATABASE \
    -e MYSQL_USER=$MYSQL_USER \
    -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
    mariadb:latest

#Wordpress
docker run -d --name wordpress \
    --restart always \
    --network backend-net \
    --network frontend-net \
    -v wp_data:/var/www/html \
    -e WORDPRESS_DB_HOST=db\
    -e WORDPRESS_DB_USER=$MYSQL_USER \
    -e WORDPRESS_DB_PASSWORD=$MYSQL_PASSWORD \
    -e WORDPRESS_DB_NAME=$MYSQL_DATABASE \
    wordpress:latest

#http-echo
docker run -d --name http-echo \
    --restart always \
    --network frontend-net \
    hashicorp/http-echo:latest \
    -text="Bienvenido"

#nginx
docker run -d --name nginx \
    --restart always \
    --network frontend-net \
    -p 80:80 \
    -p 7878:7878 \
    -v ./default.conf:/etc/nginx/conf.d/default.conf\
    nginx:latest

