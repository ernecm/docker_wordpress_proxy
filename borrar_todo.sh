#!/bin/bash
echo "Eliminando todo el entorno..."
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
echo "Todo ha sido eliminado"