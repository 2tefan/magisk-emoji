#!/bin/bash

. $(dirname "$0")/common.sh

VERSION="$FONT_VERSION-$PACKAGE_VERSION"

init_env

set_module_prop "<font>" "$FONT"
set_module_prop "<version>" "$VERSION"
set_module_prop "<versionCode>" "$VERSION_CODE"

set_install_script "<font>" "$FONT"
set_install_script "<version>" "$VERSION"

export_font
