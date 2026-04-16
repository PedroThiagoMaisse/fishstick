# Configuration
INSTALL_DIR="/var/fishstick"

echo "Setting Configs..."

# Create directory
sudo mkdir -p "$INSTALL_DIR"

# Copy files
sudo cp "./helper.html" "$INSTALL_DIR/"

echo "Config Complete!"