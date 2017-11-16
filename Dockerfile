FROM tomcat:8.0-jre8

RUN apt-get -y update \
  && apt-get install -y libgdal-java \
    git

# boundless
RUN git clone https://github.com/mxabierto/docker-boundless-suite suite \
  && wget -q https://github.com/mxabierto/boundless-suite/releases/download/4.9.1/BoundlessSuite-4.9.1-war.zip -O boundless.zip \
  && wget -q https://github.com/mxabierto/boundless-suite/releases/download/4.9.1/BoundlessSuite-4.9.1-ext.zip -O boundless-ext.zip

# geoserver
RUN mkdir -v -p ./suite \
    ./geoserver \
    ./webapps/geowebcache \
    /var/opt/boundless/server/geowebcache/config \
    /var/opt/boundless/server/geowebcache/tilecache \
  && unzip boundless.zip -d suite \
  && unzip boundless-ext.zip -d suite \
  && unzip suite/BoundlessSuite-latest-war/geoserver.war -d geoserver \
  && unzip suite/BoundlessSuite-latest-war/geowebcache.war -d ./webapps/geowebcache

# data folder
RUN mkdir -p /var/opt/boundless/server/geoserver/data/jdbcconfig \
  && unzip suite/BoundlessSuite-latest-war/suite-data-dir.zip -d /var/opt/boundless/server/geoserver/data

# extensions
RUN cp -t geoserver/WEB-INF/lib \
    suite/BoundlessSuite-latest-ext/vectortiles/* \
    suite/BoundlessSuite-latest-ext/wps/* \
    suite/BoundlessSuite-latest-ext/jdbcconfig/* \
  && cp suite/BoundlessSuite-latest-ext/marlin/marlin-0.7.3-Unsafe.jar lib


# config files
RUN mkdir -p -v conf/Catalina/localhost \
  && cp -t conf/Catalina/localhost/ \
    suite/geowebcache.xml \
    suite/geoserver.xml

# set suite
RUN mv geoserver webapps/ \
  && cp -t webapps \
    suite/BoundlessSuite-latest-war/composer.war \
    suite/BoundlessSuite-latest-war/dashboard.war \
    suite/BoundlessSuite-latest-war/geowebcache.war \
    suite/BoundlessSuite-latest-war/quickview.war \
    suite/BoundlessSuite-latest-war/suite-docs.war \
    suite/BoundlessSuite-latest-war/wpsbuilder.war

# remove apache admin
RUN rm -rf webapps/ROOT/* \
  && cp suite/index.jsp webapps/ROOT/

# clean
RUN rm -rf suite *.zip \
  && apt-get -s clean

ENV JAVA_OPTS '-Xms256m   -Xmx756m   -XX:SoftRefLRUPolicyMSPerMB=36000   -XX:-UsePerfData   -Dorg.geotools.referencing.forceXY=true   -Dorg.geotoools.render.lite.scale.unitCompensation=true   -Xbootclasspath/a:/usr/local/tomcat/lib/marlin-0.7.3-Unsafe.jar   -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine   -Dsun.java2d.renderer.useThreadLocal=false -Djava.library.path="/usr/lib64 /usr/lib /usr/lib/jni /opt/libjpeg-turbo/lib64"'

EXPOSE 8080
