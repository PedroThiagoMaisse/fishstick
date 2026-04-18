#!/bin/bash

clear

INSTALL_DIR="$HOME/.local/bin/fishstick"
BASHRC="$HOME/.bashrc"
ENV_DIR="$HOME/.config/fishstick"
ENV_FILE="$ENV_DIR/.env"
VAR_DIR="/var/fishstick"

echo "Starting installation..."
echo ""



echo "1 - Setting Configs/Vars..."

TIMESTAMP=$(date +%s)

echo "  w: Getting permission to remove and create var folders"

sudo mkdir -p "$VAR_DIR"
sudo mkdir -p "$VAR_DIR/images"

echo "  i: Copying static non-config files"  
sudo cp "./config/helper.html" "$VAR_DIR/"
sudo cp "./config/assets/lights.jpg" "$VAR_DIR/images/"

echo "  i: Creating .env file"
rm -rf "$ENV_DIR"
mkdir "$ENV_DIR"
sudo cp "./config/.env" "$ENV_FILE"

echo "  w: CHANGING WAYBAR AND HYPRLOCK CONFIG (also adding things to hyprland)"
echo "  w: CHANGES WILL BE DONE IN 5 SECONDS"
sleep 5

sudo mkdir -p "$VAR_DIR/backup/$TIMESTAMP"

sudo cp "$HOME/.config/hypr/hyprlock.conf" "$VAR_DIR/backup/$TIMESTAMP/hyprlock.conf"
sudo cp "$HOME/.config/hypr/hyprland.conf" "$VAR_DIR/backup/$TIMESTAMP/hyprland.conf"

sudo cp "$HOME/.config/waybar/config" "$VAR_DIR/backup/$TIMESTAMP/waybar.config"
sudo cp "$HOME/.config/waybar/style.css" "$VAR_DIR/backup/$TIMESTAMP/waybar.style.css"


echo "  w: Backup created on: $VAR_DIR/backup/$TIMESTAMP"

cp "./config/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"

SOURCE="./config/hypr/hyprland.conf"
DESTINATION="$HOME/.config/hypr/hyprland.conf"

while IFS= read -r line || [ -n "$line" ]; do
    if ! grep -Fxq "$line" "$DESTINATION"; then
        echo "$line" >> "$DESTINATION"
        echo "Added: $line"
    fi
done < "$SOURCE"

cp "./config/waybar/config" "$HOME/.config/waybar/config"
cp "./config/waybar/style.css" "$HOME/.config/waybar/style.css"


echo "1 - Complete!"
echo ""



echo "2 - Setting Commands"


FILES_DIR="commands"

mkdir -p "$HOME/.local/bin"

echo "  i: Cleaning up old installations in $INSTALL_DIR..."

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

echo "  i: Installing files from $FILES_DIR into $INSTALL_DIR..."
find "$FILES_DIR" -type f -name "*.sh" | while read -r file; do
    relative_path=${file#$FILES_DIR/}
    new_name=$(echo "$relative_path" | tr '/' '.')
    
    cp "$file" "$INSTALL_DIR/$new_name"
    
    chmod +x "$INSTALL_DIR/$new_name"
done

echo "2 - Complete!"
echo ""


echo "2.5 - Compiling Go Binary"

if [ -f "go.mod" ]; then
    echo "  i: Running go mod tidy..."
    go mod tidy
    
    echo "  i: Building fishstick binary..."
    # Build the current directory (.) into a binary named 'fishstick'
    go build -o "$INSTALL_DIR/fishstick" .
    
    if [ $? -eq 0 ]; then
        chmod +x "$INSTALL_DIR/fishstick"
        echo "  i: Binary compiled and moved to $INSTALL_DIR/fishstick"
    else
        echo "  e: Go build failed!"
        exit 1
    fi
else
    echo "  w: No go.mod found, skipping compilation."
fi

# Ensure the PATH includes the directory where the binary lives
if ! grep -q "$INSTALL_DIR" "$BASHRC"; then
    echo "  i: Adding $INSTALL_DIR to PATH in $BASHRC"
    echo '  i: export PATH="$PATH:'"$INSTALL_DIR"'"' >> "$BASHRC"
    echo "  i: Installation complete. Please run 'source ~/.bashrc' to apply changes."
else
    echo "  w: $INSTALL_DIR is already in your PATH."
fi


echo "2.5 - Complete!"
echo ""

echo "3 - Executing cleanup install.sh"

cd ./cleanup || exit
sudo ./install.sh


echo "3 - Complete!"
echo ""

echo "All Complete!"