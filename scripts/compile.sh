#! /bin/bash
ZIPGATEWAY_VERSION=$1

export PLANTUML_JAR_PATH=/opt/plantuml.jar
SOURCE_DIR=/app/zipgateway-source/$ZIPGATEWAY_VERSION/usr/local
BUILD_DIR=${SOURCE_DIR}/build

WRT_PACKAGE_FILES_DIR=${SOURCE_DIR}/WRTpackage/files

BIN_DIR=/app/bin/${ZIPGATEWAY_VERSION}

SCRIPT_DIR=/app/scripts
SCRIPT_FILES=${SCRIPT_DIR}/files

rm -rf ${BIN_DIR}

mkdir -v ${BIN_DIR}

rm -rf ${BUILD_DIR}

mkdir -v "${BUILD_DIR}"


if [[ $CROSS ]]; then
  ${SCRIPT_DIR}/cross.sh
  cmake ${SOURCE_DIR} -B${SOURCE_DIR}/build -DRPI3PLUS=Y -DCMAKE_TOOLCHAIN_FILE=${SOURCE_DIR}/cmake/debian_stretch_armhf.cmake
else
  cmake ${SOURCE_DIR} -B${SOURCE_DIR}/build -DRPI3PLUS=Y #-DDISABLE_MOCK=1
fi

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

  "7.17.01")
    cp -v ${BUILD_DIR}/src/zipgateway ${BIN_DIR}
    ;;
esac
