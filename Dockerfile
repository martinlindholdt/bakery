FROM resin/rpi-raspbian:jessie

#ENV OF_VERSION 0.9.8

MAINTAINER Martin Lindholdt <martin@lindholdt.net>

LABEL maintainer="martin@lindholdt.net"
      
WORKDIR /home
RUN mkdir app

RUN export TINI_SUBREAPER=1

RUN apt-get update 

RUN apt-get install -y --no-install-recommends build-essential git cmake pkg-config wget unzip
RUN apt-get install -y --no-install-recommends libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev

# for gui 
RUN apt-get install libgtk2.0-dev
#Optimize internal operations 
RUN apt-get install libatlas-base-dev gfortran

RUN apt-get install python2.7-dev python3-dev



# Pip 
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN sudo python get-pip.py 
RUN pip install numpy


ENV OPENCV_VERSION=3.1.0 

# get opencv
RUN wget -O opencv.zip https://github.com/Itseez/opencv/archive/${OPENCV_VERSION}.zip
RUN unzip opencv.zip

# get the conrib parts of opencv 
# wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/${OPENCV_VERSION}.zip
# unzip opencv_contrib.zip

RUN cd /home/opencv-${OPENCV_VERSION}/
RUN mkdir build
WORKDIR /home/opencv-${OPENCV_VERSION}/build

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
#    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-${OPENCV_VERSION}/modules \
    -D BUILD_EXAMPLES=ON .. 


RUN make -j4
RUN make install
RUN ldconfig

WORKDIR /home


#clean up 
#RUN rm -rf opencv-${OPENCV_VERSION}

RUN apt-get remove build-essential git cmake pkg-config wget unzip  
RUN rm -rf /var/lib/apt/lists/*
#RUN apt-get clean 


RUN git clone https://github.com/opencv/opencv.git

VOLUME ["/home/app"]
