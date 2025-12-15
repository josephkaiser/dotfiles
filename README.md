# Joe's dotfiles

My personal dotfile repo with OS-aware installation.

## Structure

```
~/.dotfiles/
├── common/          # Configs shared across all systems
│   ├── .tmux.conf
│   ├── nvim/
│   ├── alacritty/
│   ├── fish/
│   └── zathura/
├── mac/             # macOS-specific configs
│   ├── .tmux.conf
│   └── Brewfile
├── linux/           # Linux-specific configs (Arch/Ubuntu)
│   ├── .tmux.conf
│   ├── hypr/
│   ├── waybar/
│   ├── tlp/
│   └── bin/
│       └── toggle-waybar.sh
└── scripts/
    └── install.sh   # OS-aware installation script
```

## Installation

The install script automatically detects your OS (macOS, Arch Linux, or Ubuntu) and applies only the relevant configurations.

```bash
git clone https://github.com/josephkaiser/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/install.sh
```

### What the installer does:

1. **Detects your OS** (macOS, Arch, Ubuntu, or generic Linux)
2. **Links common configs** (nvim, alacritty, fish, zathura, tmux base)
3. **Links OS-specific configs**:
   - **macOS**: Brewfile for package management, macOS-specific tmux config
   - **Linux**: Hyprland, Waybar, TLP configs, and utility scripts
4. **Runs OS-specific setup**:
   - **macOS**: Installs packages via `brew bundle`
   - **Linux**: Provides informational messages about required packages

## Configuration Details

### Common Configs (All Systems)

- **Neovim**: Modern IDE features with Lazy plugin management
- **Alacritty**: Fast terminal emulator
- **Fish**: User-friendly shell with autocomplete
- **Zathura**: PDF viewer
- **Tmux**: Terminal multiplexer (base config)

### macOS-Specific

- **Brewfile**: Homebrew packages and casks
- **Tmux**: Configured with macOS-specific fish shell paths

### Linux-Specific

- **Hyprland**: Window manager configuration
- **Waybar**: Status bar for Wayland
- **TLP**: Power management (battery/AC modes)
- **bin/toggle-waybar.sh**: Script to toggle Waybar for OLED preservation

## Desktop: Hyprland (Linux)

Super minimal desktop environment configuration I use for beater thinkpad before macbook ;)

**Default apps:**
- Terminal: Alacritty
- File manager: Thunar
- Menu: Rofi
- Browser: Firefox

**Startup apps:**
- Waybar
- lxqt-policykit

## Terminal: Alacritty

Chose Alacritty for the speed. I use a simple config just to make the font size bigger and get nicer fontstyle.
Uses fish instead of default bash. I like the default autocomplete :)

tmux for multiplexing... although tabbed applications are supported natively on macs, doesn't play well with aerospace... tmux is reliable and consistent and clean.

## Text Editor: Neovim

Includes modern features of IDE in lightweight config that aims to stay pretty minimal while adding some QoL.

**Features:**
- Uses `:Lazy` for plugin management
- Uses `:Mason` for LSP, DAP, Linter, Formatter install and updates
- Mason configured for: bash-language-server bashls, black, clangd, css-lsp cssls, debugpy, html-lsp html, json-lsp jsonls, pylint, pyright
- DAP and DAP-UI for debugging with python set up
- Oil file tree
- Bufferline for file tabs
- Several mini.nvim packages, including mini.animations for nice scrolling :)
- Using Kanagawa colorscheme for now. Not sure if I like the actual colors or just the name and its origin
- Spacebar as `<leader>` key, mini.clue for hints
- Toggle comments with space + /
- autotag for easier html tag writing
