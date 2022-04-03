#!/bin/bash

. $(dirname "$0")/common.sh

if [ -z "${FONT_VERSION}" ]; then 
    echo "Defaults not working... Please use bash"
    exit 1
fi

init_env

set_module_prop "<font>" "$FONT"
set_module_prop "<version>" "$VERSION"
set_module_prop "<versionCode>" "$VERSION_CODE"

set_install_script "<font>" "$FONT"
set_install_script "<version>" "$VERSION"

export_font
