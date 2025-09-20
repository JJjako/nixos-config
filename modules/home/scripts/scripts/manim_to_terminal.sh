#!/usr/bin/env bash

# Get text from clipboard
text=$(wl-paste)
if [ -z "$text" ]; then
    echo "Clipboard is empty! Copy text first."
    exit 1
fi

# Switch to Desktop 3
hyprctl dispatch workspace 3
sleep 0.3  # wait a short moment for the desktop switch

# Paste text into the focused window
echo "$text" | wtype
sleep 0.2

# Switch back to Desktop 1
hyprctl dispatch workspace 1
