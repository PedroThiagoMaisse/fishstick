#!/bin/bash


echo -e "   i: Setting vars"
REAL_USER=$(who | awk '{print $1}' | head -n1)
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

echo -e "   i: Stopping timer"
sudo systemctl stop fish-cleanup.timer 2>/dev/null


echo -e "   i: Starting main.sh Setup"

sudo mkdir -p "$REAL_HOME/.local/bin/fishstick/"
sudo cp main.sh "$REAL_HOME/.local/bin/fishstick/cleanup.sh"

sudo chown "$USER:$USER" "$REAL_HOME/.local/bin/fishstick/cleanup.sh"
sudo chmod +x "$REAL_HOME/.local/bin/fishstick/cleanup.sh"


echo -e "   i: Starting .service Setup"
sudo cp ./config/fish-cleanup.service /etc/systemd/system/fish-cleanup.service 
sudo sed -i "s/#usr/$REAL_USER/g" /etc/systemd/system/fish-cleanup.service


sudo chown root:root /etc/systemd/system/fish-cleanup.service
sudo chmod 644 /etc/systemd/system/fish-cleanup.service


echo -e "   i: Starting .timer Setup"
sudo cp ./config/fish-cleanup.timer /etc/systemd/system/fish-cleanup.timer 

sudo chown root:root /etc/systemd/system/fish-cleanup.timer
sudo chmod 644 /etc/systemd/system/fish-cleanup.timer

echo -e "   i: Reloading Daemon"
sudo systemctl daemon-reload

echo -e "   i: enabling and starting .timer"
sudo systemctl enable fish-cleanup.timer
sudo systemctl start fish-cleanup.timer