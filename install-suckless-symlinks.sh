#!/usr/bin/env bash
set -e

# ================================
# CONFIG
# ================================
REPO_DIR="$HOME/repos/suckless"
CONFIG_DIR="$HOME/.config/suckless"
BACKUP_DIR="$HOME/.config/suckless.bak.$(date +%Y%m%d-%H%M%S)"

MODULES=(
  dwm
  st
  slstatus
  dunst
  picom
  rofi
  scripts
  sxhkd
  tabbed
  wallpaper
)

echo "== Suckless symlink installer =="
echo "Repo:   $REPO_DIR"
echo "Config: $CONFIG_DIR"
echo

# ================================
# SANITY CHECKS
# ================================
if [[ ! -d "$REPO_DIR" ]]; then
  echo "❌ Repo directory not found: $REPO_DIR"
  exit 1
fi

mkdir -p "$CONFIG_DIR"

# ================================
# BACKUP
# ================================
echo "📦 Creating backup at:"
echo "  $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -a "$CONFIG_DIR/." "$BACKUP_DIR/" 2>/dev/null || true
echo

# ================================
# MAIN LOGIC
# ================================
for module in "${MODULES[@]}"; do
  CONFIG_PATH="$CONFIG_DIR/$module"
  REPO_PATH="$REPO_DIR/$module"

  # If already a symlink → leave it alone
  if [[ -L "$CONFIG_PATH" ]]; then
    echo "✔ $module is already a symlink, leaving it"
    continue
  fi

  # If real directory exists in config → move it to repo
  if [[ -d "$CONFIG_PATH" ]]; then
    echo "➡ Moving $module from config to repo"
    mkdir -p "$REPO_DIR"
    mv "$CONFIG_PATH" "$REPO_PATH"
  fi

  # Repo must exist now
  if [[ ! -d "$REPO_PATH" ]]; then
    echo "⚠️  $module not found in repo, skipping"
    continue
  fi

  # Create symlink
  echo "🔗 Linking $module"
  ln -s "$REPO_PATH" "$CONFIG_PATH"
done

echo
echo "✅ Done!"
echo "Backup created at:"
echo "  $BACKUP_DIR"
