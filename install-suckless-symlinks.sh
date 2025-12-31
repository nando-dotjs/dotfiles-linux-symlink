#!/usr/bin/env bash
set -euo pipefail

# ================================
# CONFIG
# ================================
REPO_DIR="$HOME/repos/suckless"
CONFIG_DIR="$HOME/.config/suckless"
BACKUP_DIR="$HOME/.config/suckless.bak.$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$HOME/dotfiles_symlink.log"

# Contadores para el resumen
count_created=0
count_existing=0
count_skipped=0
count_dirs_descended=0

echo "===== Suckless symlink installer =====" | tee -a "$LOG_FILE"
echo "Repo:   $REPO_DIR" | tee -a "$LOG_FILE"
echo "Config: $CONFIG_DIR" | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

# ================================
# SANITY CHECKS
# ================================
if [[ ! -d "$REPO_DIR" ]]; then
    echo "❌ Repo directory not found: $REPO_DIR" | tee -a "$LOG_FILE"
    exit 1
fi

mkdir -p "$CONFIG_DIR"

# ================================
# BACKUP
# ================================
echo "📦 Creating backup at: $BACKUP_DIR" | tee -a "$LOG_FILE"
mkdir -p "$BACKUP_DIR"
cp -a "$CONFIG_DIR/." "$BACKUP_DIR/" 2>/dev/null || true
echo | tee -a "$LOG_FILE"

# ================================
# FUNCTION TO CREATE SYMLINKS RECURSIVELY
# ================================
create_symlinks_recursively() {
    local src_dir="$1"
    local dst_dir="$2"

    mkdir -p "$dst_dir"

    for item in "$src_dir"/*; do
        local name=$(basename "$item")
        local dst_path="$dst_dir/$name"

        if [[ -L "$dst_path" ]]; then
            echo "✔ Symlink already exists: $dst_path" | tee -a "$LOG_FILE"
            ((count_existing++))
        elif [[ -d "$dst_path" ]]; then
            echo "➡ Directory exists, descending: $dst_path" | tee -a "$LOG_FILE"
            ((count_dirs_descended++))
            # Recurse into subdirectory
            create_symlinks_recursively "$item" "$dst_path"
        elif [[ -e "$dst_path" ]]; then
            echo "⚠️  File exists, skipping: $dst_path" | tee -a "$LOG_FILE"
            ((count_skipped++))
        else
            ln -s "$item" "$dst_path"
            echo "🔗 Linked $dst_path -> $item" | tee -a "$LOG_FILE"
            ((count_created++))
        fi
    done
}

# ================================
# MAIN LOGIC
# ================================
create_symlinks_recursively "$REPO_DIR" "$CONFIG_DIR"

# ================================
# SUMMARY
# ================================
echo | tee -a "$LOG_FILE"
echo "===== Summary =====" | tee -a "$LOG_FILE"
echo "Symlinks created:          $count_created" | tee -a "$LOG_FILE"
echo "Symlinks already existed:  $count_existing" | tee -a "$LOG_FILE"
echo "Files/folders skipped:     $count_skipped" | tee -a "$LOG_FILE"
echo "Directories descended:     $count_dirs_descended" | tee -a "$LOG_FILE"
echo "Backup created at: $BACKUP_DIR" | tee -a "$LOG_FILE"
echo "✅ Done!" | tee -a "$LOG_FILE"
