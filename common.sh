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
                echo "Uploading ${OUT_FILE}..."
                upload_to_gitlab
            ;;
            --update | -U)
                echo "Upgrading update.json ${OUT_FILE}..."
                update_json
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

update_json() {
    local file="Data/${FONT}/MagiskUpdate/update.json"
    local src="Data/common/MagiskUpdate/"
    local target="Data/${FONT}"
    local tag=$(git tag | tail -1)
    
    cp -r "${src}" "${target}"

    search_replace "<version>" "${VERSION}" "${file}"
    search_replace "<versionCode>" "${VERSION_CODE}" "${file}"
    search_replace "<tag>" "${tag}" "${file}"
    search_replace "<out_file>" "${OUT_FILE}" "${file}"
    search_replace "<font>" "${FONT}" "${file}"

    echo "Updated ${file}"
}