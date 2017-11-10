#!/usr/bin/env bash

# postgis
# 5432 -> default port of postgis inside the docker
echo "building postgis in port $DOCKER_POSTGIS_PORT with $DOCKER_POSTGIS_USER:$DOCKER_POSTGIS_PASSWORD"
docker pull mdillon/postgis
docker run --name postgis_boundless -e POSTGRES_PASSWORD=$DOCKER_POSTGIS_PASSWORD -e POSTGRES_USER=$DOCKER_POSTGIS_USER -p $DOCKER_POSTGIS_PORT:5432 -d mdillon/postgis


# boundless
echo "building boundless in port $DOCKER_BOUNDLESS_PORT"
docker build -t cedn/boundless . --build-arg geowebcache_conf=geowebcache.xml --build-arg geoserver_conf=geoserver.xml
docker run --name boundless -e JAVA_OPTS='-Xms256m -Xmx756m -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:-UsePerfData -Dorg.geotools.referencing.forceXY=true -Dorg.geotoools.render.lite.scale.unitCompensation=true' --link postgis_boundless:postgres -p $DOCKER_BOUNDLESS_PORT:8080 -d -t cedn/boundless





# sudo docker run -d -p 8080:8080 -p 8009:8009 -v /opt/tomcat/webapps:/opt/tomcat/webapps dordoka/tomcat
