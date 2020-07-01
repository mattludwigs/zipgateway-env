#! /bin/bash

#
# Update the `zipgateawy.cfg` file for the `zipgateway` version specificied
#
# Example:
#
# config-update 7.11.01
#
# You can update your cfg file in scripts/files/zigpateway.cfg on your host
# machine and run this command to update the correct file on the system for
# your updated config.
#
# This will require you to restart your `zipgateway` program for changes to
# take effect.

ZIPGATEWAY_VERSION=$1

SCRIPT_FILES=/app/scripts/files
BIN_DIR=/app/bin/${ZIPGATEWAY_VERSION}


cp -v ${SCRIPT_FILES}/zipgateway.cfg ${BIN_DIR}/zipgateway.cfg

