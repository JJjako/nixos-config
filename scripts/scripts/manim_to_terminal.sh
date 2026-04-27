#!/usr/bin/env bash

# Get text from clipboard
text=$(wl-paste)
if [ -z "$text" ]; then
    echo "Clipboard is empty! Copy text first."
    exit 1
fi

# Switch to Desktop 3
hyprctl dispatch workspace 3  # wait for desktop switch and window focus

# Optional: bring Kitty to front using Hyperland rules (if needed)
# hyprctl dispatch focuswindow [window_id]  # advanced, if you want to focus a specific window

# Type text into the focused window
wtype -d 1 -- "$text"
xdotool key ENTER
# Switch back to Desktop 1
hyprctl dispatch workspace 1
