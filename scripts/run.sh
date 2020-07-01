#! /bin/bash

# ./run.sh /dev/ttyUSB0 7.11.01
# the version is optional, if it is not passed in then it will deafult
# the set ZIPGATEWAY_VERSION env variable

# see the `env-list` file in the root of project to change it.

ZIPGATEWAY_VERSION=$2
ZIPGATEWAY_BIN_DIR=/app/bin/${ZIPGATEWAY_VERSION}

# mkdir -vp /dev/net
# mknod /dev/net/tun c 10 200

cd ${ZIPGATEWAY_BIN_DIR}

./zipgateway -c ${ZIPGATEWAY_BIN_DIR}/zipgateway.cfg -s $1
