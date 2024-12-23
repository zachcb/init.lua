# Init.lua for Neovim

This repository contains my config files for Neovim. Code and copy have been picked from various places across the vast internet. NVChad, Kickstart, etc.

## Pre-requisites

- [Neovim 0.10](https://github.com/neovim/neovim/releases)
- [Nerd Font](https://www.nerdfonts.com/) as your terminal font.
  - Make sure the nerd font you set doesn't end with **Mono** to prevent small icons.
  - Verify vim.g.have_nerd_font is set in init.lua to true
- [Ripgrep](https://github.com/BurntSushi/ripgrep) is required for grep searching with Telescope (OPTIONAL).
- Other command Utils
  - git
  - make
  - unzip
  - C Compiler (gcc)
  - fzf - Fuzzy finder
- Clipboard tool
  - Linux - xclip
  - MacOS - xsel
  - Windows - win32yank
- GCC, Windows users must have [mingw](https://www.mingw-w64.org/downloads/) installed and set on path.
- Make, Windows users must have [GnuWin32](https://sourceforge.net/projects/gnuwin32/) installed and set on path.
- Delete old neovim folders (check commands below)
- Language Setup:
  - If want to write Typescript, you need npm
  - If want to write Golang, you will need go
  - etc.

### Recommendations

- [zoxide](https://github.com/ajeetdsouza/zoxide) - cd replacement

## Installation

```shell
git clone https://github.com/zachcb/init.lua ~/.config/nvim

rm -rf ~/.config/nvim/.git

nvim

```

- Run `:MasonInstallAll` command after lazy.nvim finishes downloading plugins.

## Update

- `:Lazy sync` command

## Uninstall

```shell
# Linux / MacOS (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

# Flatpak (linux)
rm -rf ~/.var/app/io.neovim.nvim/config/nvim
rm -rf ~/.var/app/io.neovim.nvim/data/nvim
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim

# Windows CMD
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data

# Windows PowerShell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

## Tips and Tricks

## Debugging

## FAQ

## Todo

- neotest
- window manager
- testing
- eslint / prettier

### Resources

- https://github.com/nvim-lualine/lualine.nvim#tabline
- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua
- https://www.reddit.com/r/neovim/comments/13pzwq6/is_this_neovim/
- https://docs.astronvim.com/
- https://nvchad.com/docs/quickstart/install
