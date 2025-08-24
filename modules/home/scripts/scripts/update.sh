#!/usr/bin/env bash
set -e

# Detect hostname → use correct flake target
HOST=$(hostname)
if [[ $HOST == "desktop" ]]; then
    TARGET="desktop"
elif [[ $HOST == "laptop" ]]; then
    TARGET="laptop"
else
    echo "⚠️ Unknown host: $HOST"
    echo "Defaulting to 'desktop'"
    TARGET="desktop"
fi

echo "Rebuilding NixOS system for $TARGET..."
if sudo nixos-rebuild switch --flake .#$TARGET --print-build-logs; then
    echo "Rebuild system ($TARGET) ... Done"
else
    echo "Rebuild system ($TARGET) ... FAILED"
    exit 1
fi

echo "Reloading Hyprland config..."
if hyprctl reload; then
    echo "Reloading Hyprland config ... ok"
else
    echo "Could not reload Hyprland (is it running?)"
fi

echo -e "\nUpdate complete."
echo "Press [Enter] to exit, [r] to commit config, [x] to quit without commit."

read -n 1 -r choice
echo ""

if [[ $choice == "r" ]]; then
    cd ~/nixos-config || exit 1
    git add .
    git commit -m "Update NixOS config ($TARGET) on $(date '+%Y-%m-%d %H:%M:%S')"
    echo "✅ Changes committed."
elif [[ $choice == "x" ]]; then
    echo "❌ Exiting without commit."
else
    echo "Exiting."
fi
