#!/bin/bash

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" == "Playing" ]; then
    art=$(playerctl metadata mpris:artUrl | sed 's|^file://||')
     echo "$art"
else
    echo ""
fi
