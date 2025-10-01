#!/usr/bin/env bash

wallpaper_path="$HOME/Pictures/wallpapers"
wallpapers_folder="$HOME/Pictures/wallpapers/gruvbox-wallpapers"

current_wallpaper=$(readlink "$wallpaper_path/wallpaper" 2> /dev/null)
current_wallpaper_name="$(basename "$current_wallpaper")"

# Find all images recursively (jpg, png, jpeg, etc.)
mapfile -t wallpaper_list < <(find "$wallpapers_folder" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))

wallpaper_count=${#wallpaper_list[@]}

while true; do
    wallpaper_file="${wallpaper_list[RANDOM % wallpaper_count]}"
    wallpaper_name="$(basename "$wallpaper_file")"

    if [[ "$wallpaper_name" != "$current_wallpaper_name" ]]; then
        break
    fi
done

ln -sf "$wallpaper_file" "$wallpaper_path/wallpaper"
wall-change "$wallpaper_path/wallpaper" &
