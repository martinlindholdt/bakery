FROM docker.io/project31/aarch64-alpine-qemu:3.5-7

ARG baseImageVersion 
ENV OF_VERSION 0.9.8

MAINTAINER Martin Lindholdt <martin@lindholdt.net>

LABEL of_version=$OF_VERSION \ 
      maintainer="martin@lindholdt.net"


RUN [ "cross-build-start" ]

WORKDIR /home

# add repos to apk 
RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n @edge http://nl.alpinelinux.org/alpine/edge/main\n @testing http://nl.alpinelinux.org/alpine/edge/testing\n @community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk add --update --no-cache wget git nano bash 
RUN apk add --update --no-cache make gcc glew freeglut gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-libav libxcursor boost
RUN rm /var/cache/apk/* 


RUN wget http://openframeworks.cc/versions/v${OF_VERSION}/of_v${OF_VERSION}_linuxarmv6l_release.tar.gz
RUN tar -xzvf of_v${OF_VERSION}_linuxarmv6l_release.tar.gz
RUN mv of_v${OF_VERSION}_linuxarmv6l_release openFrameworks

#RUN cd /openFrameworks/scripts/linux/debian/; ./install_dependencies.sh -y
#RUN cd /openFrameworks/scripts/linux/debian/; ./install_codecs.sh

#RUN apk add --update make pkg-config gcc openal glew freeglut freeimage gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-libav opencv libxcursor assimp boost

#RUN apk add assimp freeimage openal opencv pkg-config --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/
#RUN apk add assimp freeimage openal opencv pkg-config --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing
#RUN apk add assimp freeimage openal opencv pkg-config --repository http://dl-3.alpinelinux.org/alpine/edge/testing/aarch64/

#RUN apk add --update --no-cache assimp@testing freeimage@testing openal@testing opencv@testing pkg-config@testing



#RUN wget https://github.com/WatershedArts/Footfall/blob/master/getrepos.sh 
RUN wget https://raw.githubusercontent.com/WatershedArts/Footfall/master/getrepos.sh
RUN chmod +x getrepos.sh 
RUN ./getrepos.sh 

WORKDIR /home/openFrameworks/apps 
RUN git clone https://github.com/WatershedArts/Footfall.git 
WORKDIR /home/openFrameworks/apps/Footfall/Footfall
RUN make -j3 

##RUN apt-get install  libmpg123-dev gstreamer1.0 gstreamer1.0-plugins-ugly -y
#RUN apk add mpg123-dev gstreamer 

#RUN cd /openFrameworks/scripts/linux/; ./compileOF.sh -j3

#RUN mkdir /openFrameworks/apps/myApps/app/; ln -s /openFrameworks/apps/myApps/app/ /app

#WORKDIR /openFrameworks/apps/myApps/app
#CMD make -j4; make RunRelease

RUN [ "cross-build-end" ]