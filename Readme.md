Este proyecto práctico realiza el despliegue de de una infraestructura de microservicios mediante Docker en una máquina virtual con Ubuntu Server.

Arquitectura del Sistema

La infraestructura está compuesta por los siguientes contenedores:

Nginx: Proxy inverso y único punto de entrada (puerto 80 y 7878).

WordPress: Sistema de gestión de contenidos que estará conectado a las redes backend-net y frontend-net.

Mariadb: Sistema de gestión de base de datos para Wordpress aislado en la red backend-net.

HTTP-Echo: Servicio que devuelve un texto de bienvenida.

Estructura del proyecto:

-cortafuegos.sh: Configura ufw para que solo sean visibles los puertos 22, 80 y 7878. 

-deploy.sh: Script que crea redes, volúmenes y levanta los contenedores.

-borrar_todo.sh: Script que borra contenedores, redes y volúmenes.

-borrar_con_persistencia.sh: Script que borra solo contenedores y redes 

-default.conf: Configuración de Nginx como proxy inverso (Este no se ejecuta).

-compose.yaml`: Traducción de la infraestructura a formato YAML.
