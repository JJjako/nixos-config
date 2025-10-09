#!/usr/bin/env bash
set -euo pipefail

# --- Detect target system ---
HOST=$(hostname)
case "$HOST" in
  desktop) TARGET="desktop" ;;
  laptop) TARGET="laptop" ;;
  *) 
    echo "⚠️ Unknown host: $HOST → defaulting to 'desktop'"
    TARGET="desktop"
    ;;
esac

echo "Rebuilding NixOS for: $TARGET"
if sudo nixos-rebuild switch --flake .#"$TARGET"; then
    echo "Rebuild successful"
else
    echo "❌ Rebuild failed"
    read
    exit 1
fi

# --- Reload Hyprland (if running) ---
if pgrep -x hyprland >/dev/null; then
    hyprctl reload && echo "Hyprland reloaded"
else
    echo "⚠️ Hyprland not running — skipping reload"
fi

notify-send "NixOS rebuild" "System update complete for $TARGET"

# --- Ask user what to do next ---
echo


# --- Function for repo sync ---
sync_repo() {
    local repo_path=$1
    local label=$2

    echo "Syncing $label ($repo_path)..."
    cd "$repo_path" || { echo "❌ Can't cd into $repo_path"; return 1; }

    if [ ! -d .git ]; then
        echo "❌ $repo_path is not a Git repository."
        return 1
    fi

    git add .
    git commit -m "Update $label ($TARGET) on $(date '+%Y-%m-%d %H:%M:%S')" || true
    git push
    git fetch --all
    git pull --rebase

    local branch latest
    branch=$(git rev-parse --abbrev-ref HEAD)
    latest=$(git log -1 --pretty=format:"%h - %s")
    notify-send "Git: $label" "Branch: $branch\nLatest: $latest"
    echo "✅ $label synced."
}

# --- Sync both repos ---
sync_repo "$HOME/nixos-config" "NixOS config"
sync_repo "$HOME/shared" "Shared directory"

echo
echo "Update + push complete!"
