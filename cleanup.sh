#!/bin/bash
echo "Removing the entire environment, except volumes..."
echo
#deteniendo contenedores
docker stop nginx http-echo wordpress db
#eliminando contenedores
docker rm -f nginx http-echo wordpress db
#eliminando redes
docker network rm backend-net frontend-net
echo ""
echo "Finished"