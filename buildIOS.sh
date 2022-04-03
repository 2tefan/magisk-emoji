#!/bin/bash

. $(dirname "$0")/common.sh

set -a # Export variables
: "${FONT_VERSION:=15.4}"
: "${PACKAGE_VERSION:=2}"

: "${VERSION_CODE:=2}"
: "${FONT:=ios}"
set +a # Stop

if [ -z "${FONT_VERSION}" ]; then 
    echo "Defaults not working... Please use bash"
    exit 1
fi

build
