#!/bin/bash

. $(dirname "$0")/common.sh

FONT_VERSION=2.034
PACKAGE_VERSION=2

VERSION_CODE=2
FONT=ios


init_env

set_module_prop "<font>" "$FONT"
set_module_prop "<version>" "$VERSION"
set_module_prop "<versionCode>" "$VERSION_CODE"

set_install_script "<font>" "$FONT"
set_install_script "<version>" "$VERSION"

export_font
