#!/bin/bash

#volumenes
docker volume create db_data
docker volume create wp_data

#red
docker network create backend-net
docker network create frontend-net

#Mariadb
docker run -d --name db \
    --restart always \
    --network backend-net \
    -v db_data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=somewordpress \
    -e MYSQL_DATABASE=wordpress \
    -e MYSQL_USER=wordpress \
    -e MYSQL_PASSWORD=wordpress \
    mariadb:latest

#Wordpress
docker run -d --name wordpress \
    --restart always \
    --network backend-net \
    --network frontend-net \
    -v wp_data:/var/www/html \
    -e WORDPRESS_DB_HOST=db\
    -e WORDPRESS_DB_USER=wordpress \
    -e WORDPRESS_DB_PASSWORD=wordpress \
    -e WORDPRESS_DB_NAME=wordpress \
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

