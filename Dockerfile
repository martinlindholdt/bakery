FROM docker.io/project31/aarch64-alpine-qemu:3.5-7

RUN [ "cross-build-start" ]

ENV OF_VERSION 0.9.8

# RUN apt-get update && apt-get install -y wget apt-utils

RUN apk add --no-cache wget 
#        http://openframeworks.cc/versions/v0.9.8/of_v0.9.8_linuxarmv6l_release.tar.gz 
RUN wget http://openframeworks.cc/versions/v${OF_VERSION}/of_v${OF_VERSION}_linuxarm61_release.tar.gz
RUN tar -xzvf /of_v${OF_VERSION}_linuxarm61_release.tar.gz
RUN mv /of_v${OF_VERSION}_linuxarm61_release /openFrameworks

RUN cd /openFrameworks/scripts/linux/debian/; ./install_dependencies.sh -y
#RUN cd /openFrameworks/scripts/linux/debian/; ./install_codecs.sh

#RUN apt-get install  libmpg123-dev gstreamer1.0 gstreamer1.0-plugins-ugly -y

RUN cd /openFrameworks/scripts/linux/; ./compileOF.sh -j3

RUN mkdir /openFrameworks/apps/myApps/app/; ln -s /openFrameworks/apps/myApps/app/ /app

WORKDIR /openFrameworks/apps/myApps/app
CMD make -j4; make RunRelease

RUN [ "cross-build-end" ]