REPO_PATH="~/nixos-config"

# Check if it's a Git repository
if [ ! -d "$REPO_PATH/.git" ]; then
    notify-send "Git Update" "Error: $REPO_PATH is not a Git repository."
    exit 1
fi

# Move to the repo
cd "$REPO_PATH" || exit 1

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
