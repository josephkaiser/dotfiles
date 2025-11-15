# Joe's dotfiles

My personal dotfile repo.


## Install:
```bash
git clone https://github.com/josephkaiser/dotfiles.git ~/dotfiles
./install.sh
```
## 0. Linux Misc.

- bin folder with a bash script to toggle waybar on and off to preserve OLED monitors
- tlp with battery and AC modes + battery longevity / preservation charge limits
- waybar config that is basically default minus a few things...


## 1. Desktop: Hyprland

Super minimal desktop environment configuration I use for beater thinkpad before macbook ;)

**Default apps:**
- Terminal: Alacritty
- File manager: Thunar
- Menu: Rofi
- Browser: Firefox

**Startup apps:**
- Waybar
- lxqt-policykit

## 2. Terminal: Alacritty

Chose Alacritty for the speed. I use a simple config just to make the font size bigger and get nicer fontstyle.
Uses fish instead of default bash. I like the default autocomplete :)

tmux for multiplexing... although tabbed applications are supported natively on macs, doesn't play well with aerospace... tmux is reliable and consistent and clean.

## 3. Text Editor: Neovim

Includes modern features of IDE in lightweight config that aims to stay pretty minimal while adding some QoL.

**Features:**
- Uses `:Lazy` for plugin management
- Uses `:Mason` for LSP, DAP, Linter, Formatter install and updates
- LSP configured for 
    ◍ bash-language-server bashls
    ◍ black
    ◍ clangd
    ◍ css-lsp cssls
    ◍ debugpy
    ◍ html-lsp html
    ◍ json-lsp jsonls
    ◍ pylint
    ◍ pyright
- DAP and DAP-UI for debugging with python set up
- 
- Oil file tree
- Bufferline for file tabs
- Several mini.nvim packages, including mini.animations for nice scrolling :)
- Using Kanagawa colorscheme for now. Not sure if I like the actual colors or just the name and its origin
- Spacebar as `<leader>` key, mini.clue for hints
- Toggle comments with space + /
