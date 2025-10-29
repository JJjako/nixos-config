#!/usr/bin/env bash
set -e

APPDIR="$HOME/.local/share/applications"
mkdir -p "$APPDIR"

read -p "App Name (Display name): " NAME
read -p "Command to run: " CMD
read -p "Icon path (optional): " ICON
read -p "Run in terminal? (y/N): " TERM

FILENAME="$(echo "$NAME" | tr ' ' '_' | tr '[:upper:]' '[:lower:]').desktop"
FILE="$APPDIR/$FILENAME"

cat > "$FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$NAME
Exec=$CMD
EOF

if [[ -n "$ICON" ]]; then
    echo "Icon=$ICON" >> "$FILE"
fi

if [[ "$TERM" =~ ^[Yy]$ ]]; then
    echo "Terminal=true" >> "$FILE"
else
    echo "Terminal=false" >> "$FILE"
fi

echo "Categories=Utility;" >> "$FILE"
chmod +x "$FILE"

echo "✅ Added $NAME → available in Rofi now."
