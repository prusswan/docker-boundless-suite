FROM tomcat:8.0-jre8
MAINTAINER Leo Castañeda<leodcastaneda@gmail.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl

RUN apt-get -y update


## boundless
RUN wget https://www.dropbox.com/s/15ot9ubx35mr0aa/BoundlessSuite-4.9.1-war.zip?dl=0 -O boundless.zip
RUN unzip boundless.zip

RUN mv ./BoundlessSuite-latest-war/* ./webapps

# cleanning
RUN rm -rf boundless.zip ./BoundlessSuite-latest-war
