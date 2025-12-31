#!/usr/bin/env bash
set -e

REPO_DIR="$HOME/repos/suckless"
CONFIG_DIR="$HOME/.config/suckless"
BACKUP_DIR="$HOME/.config/suckless.bak.$(date +%Y%m%d-%H%M%S)"

ITEMS=(
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

mkdir -p "$BACKUP_DIR"

for item in "${ITEMS[@]}"; do
  SRC="$REPO_DIR/$item"
  DEST="$CONFIG_DIR/$item"

  # Repo must contain the item
  if [[ ! -e "$SRC" ]]; then
    echo "⚠️  $item not found in repo, skipping"
    continue
  fi

  # Already a symlink → leave it alone
  if [[ -L "$DEST" ]]; then
    echo "✔ $item is already a symlink, leaving it"
    continue
  fi

  # Real directory → convert to symlink
  if [[ -d "$DEST" ]]; then
    echo "📦 Backing up real directory: $item"
    mv "$DEST" "$BACKUP_DIR/"
    echo "🔗 Linking $item"
    ln -s "$SRC" "$DEST"
    continue
  fi

  # Doesn't exist → just create the symlink
  if [[ ! -e "$DEST" ]]; then
    echo "➕ Creating symlink for missing $item"
    ln -s "$SRC" "$DEST"
  fi
done

echo
echo "✅ Done!"
echo "Backup created at:"
echo "  $BACKUP_DIR"
