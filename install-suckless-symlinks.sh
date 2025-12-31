#!/usr/bin/env bash

set -e

REPO="$HOME/repos/suckless"
CONFIG="$HOME/.config/suckless"
BACKUP="$HOME/.config/suckless-backup-$(date +%Y%m%d-%H%M)"

COMPONENTS=(
  rofi
  scripts
  wallpaper
  dunst
  picom
  dwm
  st
  slstatus
  sxhkd
  tabbed
)

echo "== Installing suckless symlinks =="
echo "Repo:   $REPO"
echo "Target: $CONFIG"
echo "Backup: $BACKUP"
echo

mkdir -p "$BACKUP"

for item in "${COMPONENTS[@]}"; do
  SRC="$REPO/$item"
  DST="$CONFIG/$item"

  echo "▶ Processing: $item"

  if [[ ! -d "$SRC" ]]; then
    echo "  ❌ Source not found: $SRC — skipping"
    continue
  fi

  # If already correct symlink, skip
  if [[ -L "$DST" && "$(readlink -f "$DST")" == "$SRC" ]]; then
    echo "  ✅ Symlink already correct"
    continue
  fi

  # Backup existing
  if [[ -e "$DST" || -L "$DST" ]]; then
    echo "  📦 Backing up existing $item"
    mv "$DST" "$BACKUP/"
  fi

  echo "  🔗 Creating symlink"
  ln -s "$SRC" "$DST"
  echo
done

echo "✅ Done!"
echo "You can now reload dwm / restart X"
