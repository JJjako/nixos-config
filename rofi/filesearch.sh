#!/usr/bin/env bash

FOLDER="$HOME/nixos-config"

# Find text-related files
mapfile -t files < <(find "$FOLDER" -type f \( -name "*.sh" -o -name "*.md" -o -name "*.nix" -o -name "auswahl" -o -name "*.tsv" \))

# Build menu entries: filename + [parent folder]
entries=()
for f in "${files[@]}"; do
    name=$(basename "$f")
    parent=$(basename "$(dirname "$f")")
    entries+=("$name [$parent]")
done

# Show Rofi menu
selected=$(printf '%s\n' "${entries[@]}" | rofi -dmenu -i -p "Text files:")

# Find matching file
for i in "${!entries[@]}"; do
    if [[ "${entries[$i]}" == "$selected" ]]; then
        fullpath="${files[$i]}"
        break
    fi
done

# Open in nano (or change to your editor)
[ -n "$fullpath" ] && subl "$fullpath"
