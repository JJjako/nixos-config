#!/usr/bin/env bash
set -e

# Path to your flake repo
REPO_PATH="$HOME/nixos-config"
cd "$REPO_PATH" || { echo "❌ Repo path not found: $REPO_PATH"; exit 1; }

# Detect hostname → pick flake target
HOST=$(hostname)
if [[ $HOST == "desktop" ]]; then
    TARGET="desktop"
elif [[ $HOST == "laptop" ]]; then
    TARGET="laptop"
else
    echo "⚠️ Unknown host: $HOST → defaulting to desktop"
    TARGET="desktop"
fi

# Rebuild (quiet on success, show log on failure)
echo -n "Rebuilding NixOS system for $TARGET... "
if sudo nixos-rebuild switch --flake .#$TARGET --print-build-logs >/tmp/rebuild.log 2>&1; then
    echo "Done"
else
    echo "FAILED"
    echo "---- nixos-rebuild log ----"
    cat /tmp/rebuild.log
    exit 1
fi

# Hyprland reload (don’t error if not running)
echo -n "Reloading Hyprland config... "
if hyprctl reload >/tmp/hypr.log 2>&1; then
    echo "ok"
else
    echo "skipped"
fi

# Garbage collect (quiet)

# --- Git: fetch → rebase → commit (if changes) → push ---
if [ -d ".git" ]; then
    # Try to sync first (won’t abort on failure)
    if ! (git fetch --all && git pull --rebase); then
        echo "⚠️ Git fetch/pull failed (offline?), continuing…"
    fi

    git add .
    if ! git diff --cached --quiet; then
        if git commit -m "Update NixOS config ($TARGET) on $(date '+%Y-%m-%d %H:%M:%S')"; then
            if ! git push; then
                echo "⚠️ Push failed; commit saved locally."
            fi
        fi
        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
        LATEST_COMMIT=$(git log -1 --pretty=format:"%h - %s")
        notify-send "Git Update" "Branch: $CURRENT_BRANCH\nLatest: $LATEST_COMMIT" || true
        echo "✅ Changes committed."
    else
        echo "ℹ️ No changes to commit."
    fi
else
    echo "❌ Error: $REPO_PATH is not a Git repository."
fi

echo -e "\n✨ Update complete. Press Enter to exit."