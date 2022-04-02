#!/bin/bash

. $(dirname "$0")/common.sh

VERSION=2.034-1
VERSION_CODE=2
FONT=noto


init_env

set_module_prop "<font>" "$FONT"
set_module_prop "<version>" "$VERSION"
set_module_prop "<versionCode>" "$VERSION_CODE"

set_install_script "<font>" "$FONT"
set_install_script "<version>" "$VERSION"

export_font
