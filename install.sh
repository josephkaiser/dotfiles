#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/dotfiles"
BREWFILE="$REPO/Brewfile"
VENV_DIR="$HOME/.local/venvs/dotfiles"

echo "Starting dotfiles install..."

# ------------------------
# brew install
# ------------------------
if [ ! -f "$BREWFILE" ]; then
    echo "Error: Brewfile not found at $BREWFILE"
    exit 1
fi

brew bundle install --file="$BREWFILE"

# ------------------------
# check ~/.config exists
# ------------------------
if [ ! -d "$HOME/.config" ]; then
    echo "Error: ~/.config does not exist. Please create it first."
    exit 1
fi

# ------------------------
# symlinks
# ------------------------
echo "Creating symlinks..."

ln -sf "$REPO/.tmux.conf" "$HOME/.tmux.conf"
ln -snf "$REPO/alacritty" "$HOME/.config/alacritty"
ln -snf "$REPO/nvim" "$HOME/.config/nvim"
ln -snf "$REPO/fish" "$HOME/.config/fish"
ln -snf "$REPO/zathura" "$HOME/.config/zathura"

echo "Symlinks created."

# ------------------------
# persistent venv for debugpy
# ------------------------
echo "Setting up debugpy virtual environment..."

if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 not found. Please install it first."
    exit 1
fi

mkdir -p "$(dirname "$VENV_DIR")"
python3 -m venv "$VENV_DIR"

"$VENV_DIR/bin/python" -m pip install --upgrade pip
"$VENV_DIR/bin/python" -m pip install debugpy

echo "debugpy installed to $VENV_DIR"
echo "Point your nvim-dap adapter to: $VENV_DIR/bin/python"

echo "✅ Dotfiles install complete."
