#!/usr/bin/env bash
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

dunstctl set-paused toggle

pkill -SIGRTMIN+1 waybar