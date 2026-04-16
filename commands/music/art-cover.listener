#!/bin/bash

TARGET="/tmp/kog/artCover.png"
TARGET_DIR=$(dirname "$TARGET")
LAST=""

mkdir -p "$TARGET_DIR"

playerctl -a metadata --format '{{mpris:artUrl}}' -F | while read -r line; do
    ART_PATH=$(/home//kog/status/executables/media/art-cover-path.get.sh)

    if [ -n "$ART_PATH" ] && [ -f "$ART_PATH" ]; then
        if [ "$ART_PATH" != "$LAST" ]; then
            mkdir -p "$TARGET_DIR"
            cp "$ART_PATH" "$TARGET"
            LAST="$ART_PATH"
        fi
    else
        if [ -f "$TARGET" ]; then
            rm -f "$TARGET"
        fi
        LAST=""
    fi
done