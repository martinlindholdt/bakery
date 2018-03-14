#FROM docker.io/project31/aarch64-alpine-qemu:3.5-7
FROM arm32v6/alpine:3.5 
#FROM /alpine:3.5 

#ENV OF_VERSION 0.9.8

MAINTAINER Martin Lindholdt <martin@lindholdt.net>

LABEL maintainer="martin@lindholdt.net"
    #of_version=$OF_VERSION \ 
      


#RUN [ "cross-build-start" ]

WORKDIR /home
RUN mkdir app


# add repos to apk 
#RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n @edge http://nl.alpinelinux.org/alpine/edge/main\n @testing http://nl.alpinelinux.org/alpine/edge/testing\n @community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN echo -e '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN echo -e '@community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

RUN apk add --update --no-cache --virtual .build-dependencies wget git curl
RUN apk add --update --no-cache --virtual .debug-dependencies nano bash ca-certificates
RUN apk add --update --no-cache python3 python2 py-numpy py2-pip 
RUN apk add --update --no-cache jasper 
RUN apk add --update libjasper
RUN apk add --update --no-cache openexr@community
RUN apk add --upgrade --no-cache apk-tools@testing py-matplotlib@testing
#RUN apk add --no-cache opencv@testing 
#opencv-libs@testing 

#RUN apk add --update --no-cache make gcc glew freeglut gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-libav libxcursor boost
#RUN apk add --update  --no-cache make pkg-config gcc openal glew freeglut freeimage gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-libav opencv libxcursor assimp boost
#RUN apk add assimp freeimage openal opencv pkg-config --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/
#RUN apk add assimp freeimage openal opencv pkg-config --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing
#RUN apk add assimp freeimage openal opencv pkg-config --repository http://dl-3.alpinelinux.org/alpine/edge/testing/aarch64/
#RUN apk add --update --no-cache assimp@testing freeimage@testing openal@testing opencv@testing pkg-config@testing
#RUN apt-get install  libmpg123-dev gstreamer1.0 gstreamer1.0-plugins-ugly -y
#RUN apk add mpg123-dev gstreamer 




#RUN pip install --upgrade pip
#RUN pip install opencv-python-aarch64

#RUN pip install opencv-python-armv7l

#cvbuilder (0.2.8)                 - Package for building OpenCV 3.4.1 including Python 3 bindings from the
#                                    official sources.

#RUN pip install rpi.gpio



RUN git clone https://github.com/opencv/opencv.git


#Open frameworks 
# RUN wget http://openframeworks.cc/versions/v${OF_VERSION}/of_v${OF_VERSION}_linuxarmv6l_release.tar.gz
# RUN tar -xzvf of_v${OF_VERSION}_linuxarmv6l_release.tar.gz
# RUN mv of_v${OF_VERSION}_linuxarmv6l_release openFrameworks
#RUN cd /openFrameworks/scripts/linux/debian/; ./install_dependencies.sh -y
#RUN cd /openFrameworks/scripts/linux/debian/; ./install_codecs.sh
#RUN cd /openFrameworks/scripts/linux/; ./compileOF.sh -j3
#RUN mkdir /openFrameworks/apps/myApps/app/; ln -s /openFrameworks/apps/myApps/app/ /app
#WORKDIR /openFrameworks/apps/myApps/app
# RUN make -j4; make RunRelease

## Footfal dep installation file from github: https://github.com/WatershedArts/Footfall/blob/master/getrepos.sh 
# RUN wget https://raw.githubusercontent.com/WatershedArts/Footfall/master/getrepos.sh
# RUN chmod +x getrepos.sh 
# RUN ./getrepos.sh 

## Footfall installation and compilation 
# WORKDIR /home/openFrameworks/apps 
# RUN git clone https://github.com/WatershedArts/Footfall.git 
# WORKDIR /home/openFrameworks/apps/Footfall/Footfall
# RUN make

# Cleanup ---------------------
RUN apk del .build-dependencies 
RUN rm  -rf /var/cache/apk/* 


VOLUME ["/home/app"]

#RUN [ "cross-build-end" ]