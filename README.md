## docker-boundless
----------------
Docker para [boundless suite](https://boundlessgeo.com/).

## Inicializar
Establece las siguientes variables de entorno:
- DOCKER_POSTGIS_PORT=5433
- DOCKER_POSTGIS_PASSWORD=postgres
- DOCKER_POSTGIS_USER=postgres
- DOCKER_GEOSERVER_PORT=8090

Ejecuta el script:```$ sh run.sh```

Dejamos expuesto postgis en el puerto ```$DOCKER_POSTGIS_PORT``` para poder generar conexiones desde scripts, si no deseas que el puerto quede expuesto puedes eliminar "-p 5433:5432" en el script.

## Uso
Con los dockers iniciados puedes consultar [localhost:8080/dashboard](http://localhost:8080/dashboard/) para consultar las aplicaciones instaladas.

Las contraseñas por default para [localhost:8080/geoserver](localhost:8080/geoserver) son ```admin:geoserver```, recurda cambiarlas para mayor seguridad de tu servicio.

## Licencia
docker-boundless es software libre, y puede ser redistribuido bajo los términos especificados en nuestra [licencia](https://datos.gob.mx/libreusomx).

## Sobre México Abierto
En México Abierto creamos mecanismos de innovación y colaboración entre ciudadanos y gobierno con herramientas digitales, para	impulsar el desarrollo del país.
