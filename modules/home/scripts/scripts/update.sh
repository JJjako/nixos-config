#!/usr/bin/env bash
set -e

REPO_PATH="$HOME/nixos-config"

# Go to repo
cd "$REPO_PATH" || { echo "❌ Repo not found at $REPO_PATH"; exit 1; }

# Ensure it's a Git repo
if [ ! -d ".git" ]; then
    echo "❌ $REPO_PATH is not a Git repository."
    exit 1
fi

# Fetch and pull latest changes before rebuild
git add .
git commit -m "Update NixOS config ($TARGET) on $(date '+%Y-%m-%d %H:%M:%S')" || echo "ℹ️ Nothing to commit."
git push

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LATEST_COMMIT=$(git log -1 --pretty=format:"%h - %s")
notify-send "Git Update" "Pulled latest from $CURRENT_BRANCH\n$LATEST_COMMIT"
echo "✅ Repository is up to date."

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

# Rebuild
echo "🔧 Rebuilding NixOS system for $TARGET..."
if sudo nixos-rebuild switch --flake .#$TARGET; then
    echo "✅ Rebuild system ($TARGET) ... Done"
else
    echo "❌ Rebuild system ($TARGET) ... FAILED"
    exit 1
fi

# Reload Hyprland if running
echo "🔄 Reloading Hyprland config..."
if hyprctl reload 2>/dev/null; then
    echo "✅ Hyprland reloaded"
else
    echo "⚠️ Could not reload Hyprland (is it running?)"
fi

# Commit and push local changes
echo "💾 Committing and pushing changes..."
echo "📥 Pulling latest changes..."
git fetch --all

git pull --rebase


echo "✅ Changes pushed."

notify-send "Update complete" "Host: $TARGET"
echo -e "\n🎉 Update complete."
