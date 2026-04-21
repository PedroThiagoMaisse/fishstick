#!/usr/bin/env bash

# --- Fully Automated Arch Linux Cleanup Task ---
REAL_USER=$(who | awk '{print $1}' | head -n1)
USER_ID=$(id -u "$REAL_USER")

notify() {
    if command -v dunstify &> /dev/null; then
        # Use sudo to run as user and link to their specific DBUS path
        sudo -u "$REAL_USER" DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/"$USER_ID"/bus \
        dunstify -u critical -i "trash-can" -a "System Maintenance" "$1" "$2"
    fi
}

notify.send "Cleanup Started" "Cleaning logs, cache, and old files..."
echo "--- Starting Automated Arch Linux Cleanup ---"

ORPHANS=$(pacman -Qtdq || true)
if [[ -n "$ORPHANS" ]]; then
    echo ">> Removing orphaned packages..."
    sudo pacman -Rns --noconfirm $ORPHANS
else
    echo ">> No orphaned packages found."
fi

if command -v paccache &> /dev/null; then
    echo ">> Cleaning package cache (Keeping last 2 versions)..."
    sudo paccache -r -k 2 || true
    sudo paccache -ruk 0 || true
else
    echo ">> [!] pacman-contrib not installed."
fi

echo ">> Cleaning stale Hyprland instance signatures..."
rm -rf /tmp/hypr/* 2>/dev/null || true

SCREENSHOT_DIR="${HYPRSHOT_DIR:-$REAL_HOME/Pictures/Screenshots}"
if [ -d "$SCREENSHOT_DIR" ]; then
    echo ">> Purging screenshots older than 7 days..."
    find "$SCREENSHOT_DIR" -type f -mtime +6 -delete
else
    echo ">> Screenshot directory not found. Skipping."
fi

DOWNLOADS_DIR="$REAL_HOME/Downloads"
if [ -d "$DOWNLOADS_DIR" ]; then
    echo ">> Purging downloads older than 7 days..."
    find "$DOWNLOADS_DIR" -type f -mtime +6 -delete
else
    echo ">> Downloads directory not found."
fi

OSS_DIR="$REAL_HOME/.config/Code - OSS"
if [ -d "$OSS_DIR" ]; then
    echo ">> Purging Code - OSS Cache and Workspace Storage..."
    rm -rf "$OSS_DIR/CachedData"/*
    rm -rf "$OSS_DIR/User/workspaceStorage"/*
    rm -rf "$OSS_DIR/Backups"/*
fi

TRASH_DIR="$REAL_HOME/.local/share/Trash"
if [ -d "$TRASH_DIR" ]; then
    echo ">> Emptying system trash..."
    rm -rf "$TRASH_DIR/files"/*
    rm -rf "$TRASH_DIR/info"/*
fi

echo ">> Vacuuming journal logs older than 7 days..."
sudo journalctl --vacuum-time=7d || true

echo ">> Cleaning user thumbnails and temp files..."
rm -rf "$REAL_HOME/.cache/thumbnails/"* 2>/dev/null || true
sudo systemd-tmpfiles --clean || true

chmod 777 "$0"

echo "--- Cleanup Complete ---"

notify.send "Cleanup Complete!!!" "System is now lean and mean."
