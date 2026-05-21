#!/bin/bash
echo "Removing the entire environment..."
echo ""
#deteniendo contenedores
docker stop nginx http-echo wordpress db
#eliminando contenedores
docker rm -f nginx http-echo wordpress db
#eliminando redes
docker network rm backend-net frontend-net
#eliminando volumenes
docker volume rm db_data wp_data
echo ""
echo "Finished"