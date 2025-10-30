#!/usr/bin/env bash
set -e

# path to your dotfiles repo
REPO="$HOME/dotfiles"

# ------------------------
# symlinks
# ------------------------
ln -sf "$REPO/.tmux.conf" "$HOME/.tmux.conf"
ln -snf "$REPO/alacritty" "$HOME/.config/alacritty"
ln -snf "$REPO/nvim" "$HOME/.config/nvim"
ln -snf "$REPO/fish" "$HOME/.config/fish"
ln -snf "$REPO/zathura" "$HOME/.config/zathura"

echo "Symlinks created."

# ------------------------
# persistent venv for debugpy
# ------------------------
VENV_DIR="$HOME/.local/venvs/dotfiles"
mkdir -p "$(dirname "$VENV_DIR")"
python3 -m venv "$VENV_DIR"

"$VENV_DIR/bin/python" -m pip install --upgrade pip
"$VENV_DIR/bin/python" -m pip install debugpy

echo "debugpy installed to $VENV_DIR"
echo "Point your nvim-dap adapter to: $VENV_DIR/bin/python"
