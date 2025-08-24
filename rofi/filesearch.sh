#!/usr/bin/env bash

FOLDER="$HOME/nixos-config"

mapfile -t files < <(find "$FOLDER" -type f -name "*.nix" -o -name "*.sh")

names=()
for f in "${files[@]}"; do
    names+=("$(basename "$f")")
done

selected=$(printf '%s\n' "${names[@]}" | rofi -dmenu -i -p "Text files:")

for f in "${files[@]}"; do
    if [[ "$(basename "$f")" == "$selected" ]]; then
        fullpath="$f"
        break
    fi
done

[ -n "$fullpath" ] && kitty -e sudo nano "$fullpath"
