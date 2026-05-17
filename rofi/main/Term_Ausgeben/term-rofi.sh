#!/bin/sh

# Get a list of all environment variable names
vars=$(printenv | cut -d= -f1 | sort -u)

# Let the user pick one with rofi
choice=$(printf '%s\n' $vars | rofi -dmenu -p "Env var:")

# If nothing picked, exit quietly
[ -z "$choice" ] && exit 0

# Use indirect expansion to get its value
eval value=\$$choice

# Show result in a rofi message box
notify-send "$choice = $value"
