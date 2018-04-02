FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install wget

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add -

RUN apt-get -y update
RUN apt-get -y install openjdk-8-jdk

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.29/* /usr/local/tomcat/


RUN apt-get install -y libgdal-java \
  git unzip net-tools postgresql-10-postgis-2.4

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
RUN wget -q https://cytranet.dl.sourceforge.net/project/geoserver/GeoServer/2.12.0/extensions/geoserver-2.12.0-css-plugin.zip -O geoserver-css.zip \
  && cp -t geoserver/WEB-INF/lib \
    suite/BoundlessSuite-latest-ext/vectortiles/* \
    suite/BoundlessSuite-latest-ext/wps/* \
    suite/BoundlessSuite-latest-ext/jdbcconfig/* \
  && cp suite/BoundlessSuite-latest-ext/marlin/marlin-0.7.3-Unsafe.jar lib \
  && unzip geoserver-css.zip -d geoserver/WEB-INF/lib/


# config files
RUN mkdir -p -v conf/Catalina/localhost \
  && cp -t conf/Catalina/localhost/ \
    suite/geowebcache.xml \
    suite/geoserver.xml \
  && mv -f suite/web.xml conf/

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
#RUN rm -rf suite *.zip \
#RUN apt-get -s clean

ENV JAVA_OPTS '-Xms256m   -Xmx756m   -XX:SoftRefLRUPolicyMSPerMB=36000   -XX:-UsePerfData   -Dorg.geotools.referencing.forceXY=true   -Dorg.geotoools.render.lite.scale.unitCompensation=true   -Xbootclasspath/a:/usr/local/tomcat/lib/marlin-0.7.3-Unsafe.jar   -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine   -Dsun.java2d.renderer.useThreadLocal=false -Djava.library.path="/usr/lib64 /usr/lib /usr/lib/jni /opt/libjpeg-turbo/lib64"'

EXPOSE 8080
CMD ["catalina.sh", "run"]
