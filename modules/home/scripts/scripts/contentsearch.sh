#!/usr/bin/env bash

FOLDER="$HOME/nixos-config"
search_term=$(rofi -dmenu -p "Search text in files:")

[ -z "$search_term" ] && exit

# Dateien finden
mapfile -t files < <(find "$FOLDER" -type f \( -name "*.sh" -o -name "*.md" -o -name "*.nix" -o -name "auswahl" -o -name "*.tsv" \))

matches=()
display_entries=()
previews=()
for f in "${files[@]}"; do
    line=$(grep -in "$search_term" "$f" | head -n1)
    if [[ -n "$line" ]]; then
        matches+=("$f")
        name=$(basename "$f")
        parent=$(basename "$(dirname "$f")")
        display_entries+=("$name [$parent]")
        previews+=("$line")
    fi
done

[ ${#matches[@]} -eq 0 ] && { notify-send "No matches found"; exit; }

# Preview-Datei
PREVIEW_FILE="/tmp/rofi_preview.txt"
echo "" > "$PREVIEW_FILE"

# Vorschau-Terminal in Kitty starten
kitty @ new-window --title "Preview" "tail -f $PREVIEW_FILE" &
PREVIEW_PID=$!

cleanup() {
    kitty @ close-window --match title:Preview 2>/dev/null
    rm -f "$PREVIEW_FILE"
}
trap cleanup EXIT

# Hauptloop: Realtime-Preview beim Navigieren
fullpath=""
while true; do
    selected_index=$(printf '%s\n' "${display_entries[@]}" | rofi -dmenu -i -p "Select file:" -format 'i')
    [[ -z "$selected_index" ]] && break

    # Vorschau aktualisieren
    echo "${previews[$selected_index]}" > "$PREVIEW_FILE"

    # Auswahl merken, aber nicht sofort öffnen, damit man weiter navigieren kann
    fullpath="${matches[$selected_index]}"
done

# Nach Exit finale Datei öffnen
[[ -n "$fullpath" ]] && subl "$fullpath"
