set -euo pipefail

PKG="$1"
SYSTEM_NIX="$HOME/nixos-config/modules/core/system.nix"

# Check if package already exists
if grep -q " $PKG" "$SYSTEM_NIX"; then
  echo "⚠️  Package '$PKG' already in $SYSTEM_NIX"
  exit 0
fi

# Insert package into environment.systemPackages
sed -i "/environment\.systemPackages = with pkgs; \[/a\ \ \ \ $PKG" "$SYSTEM_NIX"
echo "✅ Added $PKG to $SYSTEM_NIX"
notify-send "Package Added" "Added $PKG to $SYSTEM_NIX"
hyprctl dispatch exec "[workspace 8 silent] kitty -d ~/nixos-config/modules/home/scripts/scripts -e ./update.sh r"
