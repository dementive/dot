#!/bin/bash

WALLPAPER_DIR="/home/dm/.config/000_wallpapers"
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f -iname "*.jpg")

if [ ${#WALLPAPERS[@]} -gt 0 ]; then
    RANDOM_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"
    if [ -f "$RANDOM_WALLPAPER" ]; then
        wbg "$RANDOM_WALLPAPER"
    fi
fi
