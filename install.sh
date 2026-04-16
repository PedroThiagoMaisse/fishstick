#!/bin/bash

# Configuration
INSTALL_DIR="$HOME/.local/bin/fishstick"
FILES_DIR="commands"
BASHRC="$HOME/.bashrc"

mkdir -p "$HOME/.local/bin"

echo "Cleaning up old installations in $INSTALL_DIR..."

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

echo "Installing files from $FILES_DIR into $INSTALL_DIR..."

find "$FILES_DIR" -type f | while read -r file; do
    relative_path=${file#$FILES_DIR/}
    new_name=$(echo "$relative_path" | tr '/' '.')
    
    cp "$file" "$INSTALL_DIR/$new_name"
    
    chmod +x "$INSTALL_DIR/$new_name"
done

if ! grep -q "$INSTALL_DIR" "$BASHRC"; then
    echo "Adding $INSTALL_DIR to PATH in $BASHRC"
    echo 'export PATH="$PATH:'"$INSTALL_DIR"'"' >> "$BASHRC"
    echo "Installation complete. Please run 'source ~/.bashrc' to apply changes."
else
    echo "$INSTALL_DIR is already in your PATH."
fi



# Running config install
cd ./config/ || exit
chmod +x ./install.sh
./install.sh