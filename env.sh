#! /bin/bash
GRIZZLY_IMAGE=grizzly
ZIPGATEWAY_SRC=$(realpath ./zipgateway-source)
SCRIPTS_DIR=$(realpath ./scripts)
BIN_DIR=$(realpath ./bin)
ZGW_CLI=$(realpath ./zgw)
MOUNTS=()

case $1 in
  "build")
    docker build --tag=$GRIZZLY_IMAGE -f Dockerfile .
    ;;

   *)
     MOUNTS+=(-v $SCRIPTS_DIR:/app/scripts)
     MOUNTS+=(-v $BIN_DIR:/app/bin)
     MOUNTS+=(-v $ZIPGATEWAY_SRC:/app/zipgateway-source)
     MOUNTS+=(--mount type=bind,source=$ZGW_CLI,target=/usr/local/sbin/zgw)

    docker run --net=host -i -t ${MOUNTS[*]} --device=/dev/ttyUSB0 --cap-add=ALL --device=/dev/net/tun $GRIZZLY_IMAGE /bin/bash 
     ;;
esac
