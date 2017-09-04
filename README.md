# docker-boundless
----------------
Docker para [boundless suite](https://boundlessgeo.com/).

## Inicializar
- Primero debes de inicializar el docker de postgis:
  1. Obtener: ```$ docker pull mdillon/postgis```
  2. Inicializar el docker: ```$ docker run --name postgis -e POSTGRES_PASSWORD=postgres -p 5433:5432 -d mdillon/postgis```

Dejamos expuesto postgis en el puerto 5433 para poder generar conexiones desde scripts, si no deseas que el puerto quede expuesto puedes eliminar "-p 5433:5432"

- Correr boundless suite
  1. Primero clona este repo ```$ git clone https://github.com/leodc/boundless-suite-docker.git```
  2. Construye el docker localmente ```$ docker build -t cedn/boundless boundless-suite-docker```
  3. Inicia el docker: ```$ docker run --name "boundless"  --link postgis:postgres -p 8080:8080 -d -t cedn/boundless```

## Uso
Con los dockers iniciados puedes consultar [localhost:8080/dashboard](http://localhost:8080/dashboard/) para consultar las aplicaciones instaladas.

## Licencia
docker-boundless es software libre, y puede ser redistribuido bajo los términos especificados en nuestra [licencia](https://datos.gob.mx/libreusomx).

## Sobre México Abierto
En México Abierto creamos mecanismos de innovación y colaboración entre ciudadanos y gobierno con herramientas digitales, para	impulsar el desarrollo del país.
