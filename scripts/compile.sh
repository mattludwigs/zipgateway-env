#! /bin/bash
ZIPGATEWAY_VERSION=$1

SOURCE_DIR=/app/zipgateway-source/$ZIPGATEWAY_VERSION/usr/local
BUILD_DIR=${SOURCE_DIR}/build

WRT_PACKAGE_FILES_DIR=${SOURCE_DIR}/WRTpackage/files

BIN_DIR=/app/bin/${ZIPGATEWAY_VERSION}

SCRIPT_FILES=/app/scripts/files

rm -rf ${BIN_DIR}

mkdir -v ${BIN_DIR}

if [ ! -d "$BUILD_DIR" ]; then
  mkdir -v "${BUILD_DIR}"
fi


cmake -B${SOURCE_DIR}/build -H${SOURCE_DIR} -DDISABLE_MOCK=1
make -C ${BUILD_DIR}


cp -v ${WRT_PACKAGE_FILES_DIR}/Portal.ca_x509.pem ${BIN_DIR}
cp -v ${WRT_PACKAGE_FILES_DIR}/ZIPR.key_1024.pem ${BIN_DIR}
cp -v ${WRT_PACKAGE_FILES_DIR}/ZIPR.x509_1024.pem ${BIN_DIR}

cp -v ${SCRIPT_FILES}/zipgateway.cfg ${BIN_DIR}/zipgateway.cfg
cp -v ${SCRIPT_FILES}/zipgateway.tun ${BIN_DIR}/zipgateway.tun

case $ZIPGATEWAY_VERSION in
  "2.81.03")
    cp -v ${BUILD_DIR}/zipgateway ${BIN_DIR}
    ;;

  "7.11.01")
    cp -v ${BUILD_DIR}/src/zipgateway ${BIN_DIR}
    ;;
esac
