#!/bin/bash

SOURCE_DIR="./source"
DEST_DIR="$HOME/.local/bin"

mkdir -p "$DEST_DIR"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found."
    exit 1
fi

for file in "$SOURCE_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        DEST_FILE="$DEST_DIR/$filename"
        
        cp "$file" "$DEST_FILE"
        
        chmod +x "$DEST_FILE"
        
        echo "Installed: $filename to $DEST_DIR"
    fi
done

echo "Deployment complete."