REPO_PATH="$HOME/nixos-config"

# Check if it's a Git repository
# Move to the repo
cd "$REPO_PATH"

# Fetch latest changes
git fetch --all

# Pull latest changes (rebase)
git pull --rebase

# Optional: show status in notification
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LATEST_COMMIT=$(git log -1 --pretty=format:"%h - %s")
notify-send "Git Update" "Branch: $CURRENT_BRANCH\nLatest: $LATEST_COMMIT"

# Optional: print to terminal
echo "Repository updated:"
git status
