#!/bin/bash
echo "Eliminando todo el entorno, excepto volúmenes..."
echo
#deteniendo contenedores
docker stop nginx http-echo wordpress db
#eliminando contenedores
docker rm -f nginx http-echo wordpress db
#eliminando redes
docker network rm backend-net frontend-net
echo ""
echo "Completado"