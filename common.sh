#!/bin/bash

BUILD_DIR=build
OUT_DIR=out

set_module_prop() {
    local target="$1"
    local replacement="$2"

    search_replace "${target}" "${replacement}" "$BUILD_DIR/module.prop"
}

set_install_script() {
    local target="$1"
    local replacement="$2"

    search_replace "${target}" "${replacement}" "$BUILD_DIR/install.sh"
}

search_replace() {
    local target="$1"
    local replacement="$2"
    local file="$3"

    sed -i "s/$target/$replacement/g" "$file"
}

init_env() {
    mkdir "$BUILD_DIR/"
    cp -a "Module/." "$BUILD_DIR/"
    cp -a "Data/$FONT/Font/v$VERSION.ttf" "$BUILD_DIR/system/fonts/NotoColorEmoji.ttf"
}

export_font() {
    mkdir "$OUT_DIR/"
    cd "$BUILD_DIR/"
    zip -r "../$OUT_DIR/Magisk-Emoji-Font-$FONT-v$VERSION.zip" *
}
