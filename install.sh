#!/usr/bin/env bash
set -euo pipefail
REPO="$HOME/dotfiles"
BREWFILE="$REPO/Brewfile"

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

echo "Dotfiles install complete."
