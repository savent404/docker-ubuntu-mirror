FROM ubuntu:18.04
MAINTAINER Proud Heng <proud.heng@gmail.com>

# To build ORB_SLAM2 using this Docker image:
# docker run -v ~/docker/ORB_SLAM2/:/ORB_SLAM2/ -w=/ORB_SLAM2/ slam-test /bin/bash -c ./build.sh

ENV OPENCV_VERSION 3.2.0
ENV OPENCV_DOWNLOAD_URL https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
ENV OpenCV_DIR opencv-$OPENCV_VERSION

# mirror for aliyun
RUN sed -i 's/^\(deb\|deb-src\) \([^ ]*\) \(.*\)/\1 http:\/\/mirrors.aliyun.com\/ubuntu \3/' /etc/apt/sources.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
    cmake \
    curl \
    gcc \
    git \
    libglew-dev \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    python-dev \
    python-numpy \
    unzip

# install OpenCV
RUN curl -fsSL "$OPENCV_DOWNLOAD_URL" -o opencv.zip \
  && unzip opencv.zip \
  && rm opencv.zip \
  && cd $OpenCV_DIR \
  && mkdir release \
  && cd release \
  && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. \
  && make -j \
  && make install

# install Eigen
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libeigen3-dev

# install Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git --depth=1 \
  && cd Pangolin \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make -j

# build ORB-SLAM2
RUN git clone https://github.com/raulmur/ORB_SLAM2.git ORB_SLAM2 --depth=1 \
  && cd ORB_SLAM2 \
  && chmod +x build.sh

VOLUME ["/ORB_SLAM2/"]

CMD ["/bin/bash -c ./build.sh"]
