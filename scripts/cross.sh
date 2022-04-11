#! /bin/bash
ZIPGATEWAY_VERSION=$1

export PLANTUML_JAR_PATH=/opt/plantuml.jar
SOURCE_DIR=/app/zipgateway-source/$ZIPGATEWAY_VERSION/usr/local
BUILD_DIR=${SOURCE_DIR}/build

WRT_PACKAGE_FILES_DIR=${SOURCE_DIR}/WRTpackage/files

BIN_DIR=/app/bin/${ZIPGATEWAY_VERSION}

SCRIPT_FILES=/app/scripts/files

apt-get update && apt-get install -y \
  curl \
  dpkg-dev \
  gcc-arm-linux-gnueabihf \
  g++-arm-linux-gnueabihf \
  libtool \
  pkg-config-arm-linux-gnueabihf \

if [ ! -d /usr/arm-linux-gnueabihf/include/openssl ]; then
curl -L https://www.openssl.org/source/openssl-1.1.1.tar.gz --output /opt/openssl.tar.gz \
 && cd /opt \
 && tar -xzf openssl.tar.gz \
 && cd openssl-*/ \
 && ./Configure linux-generic32 -DL_ENDIAN --prefix=/usr/arm-linux-gnueabihf/ --cross-compile-prefix=arm-linux-gnueabihf- shared \
 && make SHLIB_MINOR="0.2" \
 && make SHLIB_MINOR="0.2" install \
 && rm -rf /opt/openssl*
fi

if [ ! -f /usr/arm-linux-gnueabihf/include/libusb-1.0/libusb.h ]; then
curl -L https://github.com/libusb/libusb/releases/download/v1.0.21/libusb-1.0.21.tar.bz2 --output /opt/libusb.tar.bz2 \
 && cd /opt \
 && tar -xjf libusb.tar.bz2 \
 && cd libusb*/ \
 && ./configure --prefix=/usr/arm-linux-gnueabihf/ --host=arm-linux-gnueabihf --enable-udev=no \
 && make \
 && make install \
 && rm -rf /opt/libusb*
fi

if [ ! -f /usr/arm-linux-gnueabihf/include/json-c/json.h ]; then
curl -L https://s3.amazonaws.com/json-c_releases/releases/json-c-0.15.tar.gz --output /opt/json-c.tar.gz \
 && cd /opt \
 && tar -xvf json-c.tar.gz \
 && mv json-c-*/ json-c \
 && cd json-c \
 && mkdir -p /opt/json-c/build \
 && cmake /opt/json-c -B/opt/json-c/build -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=/usr/arm-linux-gnueabihf -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc \
 && cd build \
 && make all \
 && make install \
 && rm -rf /opt/json-c*
# && ./configure  --prefix=/usr/arm-linux-gnueabihf/ --host=arm-linux-gnueabihf CFLAGS="-Wimplicit-fallthrough=0" \
fi
