#!/bin/bash


echo -e "Starting Pre-setup"

echo -e "-- Setting vars"
REAL_USER=$(who | awk '{print $1}' | head -n1)
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)


echo -e "-- Stopping timer"
sudo systemctl stop kog-cleanup.timer 2>/dev/null


echo -e "Pre-setup Finished\n\n"


echo -e "Starting Script Setup..."

echo -e "-- Starting main.sh Setup"

sudo mkdir -p "$REAL_HOME/.local/bin/kog"
sudo cp main.sh "$REAL_HOME/.local/bin/kog/cleanup.sh"

sudo chown "$USER:$USER" "$REAL_HOME/.local/bin/kog/cleanup.sh"
sudo chmod +x "$REAL_HOME/.local/bin/kog/cleanup.sh"

echo -e "-- main.sh Setup Finished"

echo -e "-- Starting .service Setup"
sudo cp ./config/kog-cleanup.service /etc/systemd/system/kog-cleanup.service 

sudo chown root:root /etc/systemd/system/kog-cleanup.service
sudo chmod 644 /etc/systemd/system/kog-cleanup.service

echo -e "-- .service Setup Finished"

echo -e "-- Starting .timer Setup"

sudo cp ./config/kog-cleanup.timer /etc/systemd/system/kog-cleanup.timer 

sudo chown root:root /etc/systemd/system/kog-cleanup.timer
sudo chmod 644 /etc/systemd/system/kog-cleanup.timer

echo -e "-- .timer Setup Finished"

echo -e "Script Setup Finished\n\n"

echo -e "Applying changes..."

echo -e "-- Reloading Daemon"
sudo systemctl daemon-reload

echo -e "-- enabling and starting .timer"
sudo systemctl enable kog-cleanup.timer
sudo systemctl start kog-cleanup.timer

echo -e "kog/cleanup has been updated/installed and the timer is active."
