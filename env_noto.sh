#!/bin/bash

. $(dirname "$0")/common.sh

set -a # Export variables
: "${FONT_VERSION:=2.034}"
: "${PACKAGE_VERSION:=2}"

: "${VERSION_CODE:=2}"
: "${FONT:=noto}"
set +a # Stop
