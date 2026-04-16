#!/usr/bin/env bash

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

if [[ "$(dunstctl is-paused)" == "true" ]]; then
    echo '{"text": "󰂛", "class": "dnd", "tooltip": "Do Not Disturb: On"}'
else
    echo '{"text": "󰂚", "class": "default", "tooltip": "Do Not Disturb: Off"}'
fi