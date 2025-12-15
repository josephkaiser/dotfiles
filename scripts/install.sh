#!/usr/bin/env bash
set -euo pipefail

REPO="${HOME}/dotfiles"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ------------------------
# OS Detection
# ------------------------
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "mac"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" == "ubuntu" ]]; then
            echo "ubuntu"
        else
            echo "linux"
        fi
    else
        echo "linux"
    fi
}

OS=$(detect_os)
log_info "Detected OS: ${OS}"

# ------------------------
# Ensure ~/.config exists
# ------------------------
if [ ! -d "$HOME/.config" ]; then
    log_info "Creating ~/.config directory..."
    mkdir -p "$HOME/.config"
fi

# ------------------------
# Symlink common configs
# ------------------------
log_info "Linking common configurations..."

# Common configs that go to ~/.config
COMMON_CONFIGS=(
    "nvim"
    "alacritty"
    "fish"
    "zathura"
)

for config in "${COMMON_CONFIGS[@]}"; do
    if [ -d "${REPO_ROOT}/common/${config}" ]; then
        log_info "  Linking ${config}..."
        ln -snf "${REPO_ROOT}/common/${config}" "${HOME}/.config/${config}"
    fi
done

# Common tmux config (base)
if [ -f "${REPO_ROOT}/common/.tmux.conf" ]; then
    log_info "  Linking .tmux-common.conf..."
    ln -sf "${REPO_ROOT}/common/.tmux.conf" "${HOME}/.tmux-common.conf"
fi

# ------------------------
# Symlink OS-specific configs
# ------------------------
log_info "Linking ${OS}-specific configurations..."

# OS-specific tmux config
if [ -f "${REPO_ROOT}/${OS}/.tmux.conf" ]; then
    log_info "  Linking .tmux.conf (${OS}-specific)..."
    ln -sf "${REPO_ROOT}/${OS}/.tmux.conf" "${HOME}/.tmux.conf"
fi

# OS-specific configs that go to ~/.config
# Note: Arch GUI configs are handled separately below
if [ -d "${REPO_ROOT}/${OS}" ] && [ "$OS" != "arch" ]; then
    for item in "${REPO_ROOT}/${OS}"/*; do
        if [ -d "$item" ]; then
            name=$(basename "$item")
            # Skip if it's a directory that should be handled specially
            if [[ "$name" != "bin" ]]; then
                log_info "  Linking ${name}..."
                ln -snf "$item" "${HOME}/.config/${name}"
            fi
        fi
    done
fi

# OS-specific bin directory (skip for arch, handled separately)
if [ -d "${REPO_ROOT}/${OS}/bin" ] && [ "$OS" != "arch" ]; then
    log_info "  Linking bin directory..."
    if [ ! -d "${HOME}/.local/bin" ]; then
        mkdir -p "${HOME}/.local/bin"
    fi
    for script in "${REPO_ROOT}/${OS}/bin"/*; do
        if [ -f "$script" ] && [ -x "$script" ]; then
            name=$(basename "$script")
            log_info "    Linking ${name}..."
            ln -sf "$script" "${HOME}/.local/bin/${name}"
        fi
    done
fi

# ------------------------
# Arch Linux GUI/Desktop configs (only for Arch, not Ubuntu)
# ------------------------
if [ "$OS" == "arch" ]; then
    log_info "Linking Arch Linux desktop/GUI configurations..."
    
    # Arch-specific configs that go to ~/.config (hypr, waybar, tlp)
    if [ -d "${REPO_ROOT}/arch" ]; then
        for item in "${REPO_ROOT}/arch"/*; do
            if [ -d "$item" ]; then
                name=$(basename "$item")
                # Skip bin directory (handled separately) and .tmux.conf (already linked)
                if [[ "$name" != "bin" ]] && [[ "$name" != ".tmux.conf" ]]; then
                    log_info "  Linking ${name}..."
                    ln -snf "$item" "${HOME}/.config/${name}"
                fi
            fi
        done
    fi
    
    # Arch-specific bin directory
    if [ -d "${REPO_ROOT}/arch/bin" ]; then
        log_info "  Linking Arch bin directory..."
        if [ ! -d "${HOME}/.local/bin" ]; then
            mkdir -p "${HOME}/.local/bin"
        fi
        for script in "${REPO_ROOT}/arch/bin"/*; do
            if [ -f "$script" ] && [ -x "$script" ]; then
                name=$(basename "$script")
                log_info "    Linking ${name}..."
                ln -sf "$script" "${HOME}/.local/bin/${name}"
            fi
        done
    fi
fi

# ------------------------
# OS-specific installation steps
# ------------------------
case "$OS" in
    mac)
        log_info "Running macOS-specific installation steps..."
        
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            log_error "Homebrew is not installed. Please install it first:"
            log_error "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
        
        BREWFILE="${REPO_ROOT}/mac/Brewfile"
        if [ -f "$BREWFILE" ]; then
            log_info "  Installing packages from Brewfile..."
            brew bundle install --file="$BREWFILE"
        else
            log_warn "  Brewfile not found at ${BREWFILE}"
        fi
        ;;
    
    arch)
        log_info "Running Arch Linux-specific installation steps..."
        
        # Check for required packages (informational)
        log_info "  Make sure you have the following installed:"
        log_info "    - fish (shell)"
        log_info "    - neovim (editor)"
        log_info "    - tmux (terminal multiplexer)"
        log_info "    - alacritty (terminal emulator)"
        
        # Arch-specific: hyprland, waybar, tlp setup
        if [ -d "${REPO_ROOT}/arch/hypr" ]; then
            log_info "  Hyprland config is available at ${REPO_ROOT}/arch/hypr"
        fi
        if [ -d "${REPO_ROOT}/arch/waybar" ]; then
            log_info "  Waybar config is available at ${REPO_ROOT}/arch/waybar"
        fi
        if [ -d "${REPO_ROOT}/arch/tlp" ]; then
            log_info "  TLP configs are available at ${REPO_ROOT}/arch/tlp"
            log_info "    Copy them to /etc/tlp/ if needed (requires sudo)"
        fi
        ;;
    
    ubuntu|linux)
        log_info "Running Linux server-specific installation steps..."
        
        # Check for required packages (informational)
        log_info "  Make sure you have the following installed:"
        log_info "    - fish (shell)"
        log_info "    - neovim (editor)"
        log_info "    - tmux (terminal multiplexer)"
        ;;
    
    *)
        log_warn "Unknown OS: ${OS}. Only common configs have been linked."
        ;;
esac

log_info "Dotfiles installation complete!"
log_info "OS detected: ${OS}"
log_info "Common configs: linked"
log_info "${OS}-specific configs: linked"
