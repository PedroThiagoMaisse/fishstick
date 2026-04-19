#!/bin/bash

playerctl metadata --format '{{status}}|{{markup_escape(artist)}}|{{markup_escape(title)}}' --follow | while read -r line; do
    
    IFS='|' read -r status artist title <<< "$line"
    
    if [[ "$status" == "Playing" ]]; then
        icon="󰎈"
        class="playing"
    elif [[ "$status" == "Paused" ]]; then
        icon="󰏤"
        class="paused"
    else
        echo ""
        continue
    fi

    printf '{"text": "%s %s - %s", "class": "%s", "alt": "%s"}\n' "$icon" "$artist" "$title" "$class" "$class"
done
