#!/usr/bin/env bash

wallpaper_path="$HOME/Pictures/wallpapers"
wallpapers_folder="$HOME/Pictures/wallpapers/others"

# Rekursiv alle Bilddateien finden
mapfile -t wallpaper_list < <(find "$wallpapers_folder" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))

# Mit rofi auswählen
wallpaper_file=$(printf '%s\n' "${wallpaper_list[@]}" | rofi -dmenu -i || pkill rofi)

if [[ -f "$wallpaper_file" ]]; then
    ln -sf "$wallpaper_file" "$wallpaper_path/wallpaper"
    wall-change "$wallpaper_path/wallpaper"
else
    exit 1
fi
