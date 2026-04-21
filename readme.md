# Fishtick

## Summary

A bunch of "trash"/somewhat usable customizations and scripts for arch (btw)

Current the setup used (and only one tested) is:
- Arch
- systemd
- hyprland
- hyprlock
- waybar
- dunst

Right now, the codebase is a mess, just a bunch of .sh barely working together, but it still holds and works greatly in my day to day.

My next plans includes: changing from a bunch of .sh to binaries builded with go, abstracting (i know) most of the code, so it can easily be used in another setups, and defining and following some code / architecture directives.

## Next steps

### Public release:
- ~~Unify and organize status into commands~~
- ~~Modify my config, so it pulls files from a generic place~~
- ~~Pull the config to git~~
- ~~Create / Revise a install.sh for commands, configs and cleanup~~
    - ~~Add the creation of a generic env file~~
    - ~~Moving the wallpaper to the right spot (and call it on hyprlock)~~
    - ~~make backups of old configs~~
- ~~Revise cleanup rule~~
- ~~Revise the code~~
- ~~Revise .md~~

### 1.0:
- ~~Create a install.sh that can build from GO~~
- ~~Better organization~~
- Create internal libs and setups needed for:
    - create and setup of .services and .timers (and check if already enable / substitute old ones)
    - dbus
    - persistent state
    - selecting of features
- Change Language
    - Change command
        - notify
        - media
        - localization
        - weather
        - **battery**
        
    - Change config imports and languages
    - Change cleanup
    - Connect to dunst
    - Connect to waybar
- Add dunst configs
- Add climate to lock screen
- Revise APIs choices
- Create a dependency list and make file
- Enable a download with fully builded binaries

## Installation

Good luck!

