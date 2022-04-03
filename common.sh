#!/bin/bash

setup_vars() {
    set -a # Export variables
    : "${BUILD_DIR:=build}"
    : "${OUT_DIR:=out}"
    : "${VERSION:=$FONT_VERSION-$PACKAGE_VERSION}"
    : "${OUT_FILE:=Magisk-Emoji-Font-$FONT-v$VERSION.zip}"
    set +a # Stop
}

parse_args() {
    echo "Parsing arguments"
    setup_vars
    
    for arg in "$@"; do
        case "${arg}" in
            --build | -b)
                echo "Building..."
                build
            ;;
            --upload | -u)
                echo "Uploading..."
                echo "${OUT_FILE}"
            ;;
        esac
    done
}

build() {
    $(dirname "$0")/build.sh
}

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
    echo "Initializing environment"
    mkdir -p "$BUILD_DIR/"
    cp -a "Module/." "$BUILD_DIR/"
    cp -a "Data/$FONT/Font/v$FONT_VERSION.ttf" "$BUILD_DIR/system/fonts/NotoColorEmoji.ttf"
}

export_font() {
    echo "Exporting font..."
    mkdir -p "$OUT_DIR/"
    cd "$BUILD_DIR/"
    zip -r "../$OUT_DIR/$OUT_FILE" *
    echo "Saved in $OUT_DIR/$OUT_FILE"
}

upload_to_gitlab() {
    curl --header "JOB-TOKEN: ${CI_JOB_TOKEN}" --upload-file ${OUT_DIR}/${OUT_FILE} "${PACKAGE_REGISTRY_URL}/${OUT_FILE}"
}
