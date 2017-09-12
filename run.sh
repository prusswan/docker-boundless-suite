#!/usr/bin/env bash

# postgis
# 5432 -> default port of postgis inside the docker
echo "building postgis in port $DOCKER_POSTGIS_PORT with $DOCKER_POSTGIS_USER:$DOCKER_POSTGIS_PASSWORD"
docker pull mdillon/postgis
docker run --name postgis_boundless -e POSTGRES_PASSWORD=$DOCKER_POSTGIS_PASSWORD -e POSTGRES_USER=$DOCKER_POSTGIS_USER -p $DOCKER_POSTGIS_PORT:5432 -d mdillon/postgis


# boundless
echo "building boundless in port $DOCKER_GEOSERVER_PORT"
git clone https://github.com/mxabierto/docker-boundless-suite
docker build -t cedn/boundless docker-boundless-suite
docker run --name boundless --link postgis_boundless:postgres -p $DOCKER_GEOSERVER_PORT:8080 -d -t cedn/boundless
