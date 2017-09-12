## docker-boundless
----------------
Docker para [boundless suite](https://boundlessgeo.com/).

## Inicializar
Clona este repo:
- ```$ git clone https://github.com/mxabierto/docker-boundless-suite```

Establece las siguientes variables de entorno:
- DOCKER_POSTGIS_PORT=5433
- DOCKER_POSTGIS_PASSWORD=postgres
- DOCKER_POSTGIS_USER=postgres
- DOCKER_BOUNDLESS_PORT=8090

Ejecuta el script:
-```$ cd docker-boundless-suite```
- ```$ sh run.sh```

## Uso
Con los dockers iniciados puedes consultar ```localhost:DOCKER_BOUNDLESS_PORT/dashboard``` para ver las aplicaciones instaladas.

Las contraseñas por default para ```localhost:DOCKER_BOUNDLESS_PORT/geoserver``` son ```admin:geoserver```, recuerda cambiarlas para mayor seguridad de tu servicio.

## Licencia
docker-boundless es software libre, y puede ser redistribuido bajo los términos especificados en nuestra [licencia](https://datos.gob.mx/libreusomx).

## Sobre México Abierto
En México Abierto creamos mecanismos de innovación y colaboración entre ciudadanos y gobierno con herramientas digitales, para	impulsar el desarrollo del país.
