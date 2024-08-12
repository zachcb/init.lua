# NVIM Init.lua

## Installation

```shell
git clone --depth 0 https://github.com/zachcb/init.lua ~/.config/nvim

rm -rf ~/.config/nvim/.git
nvim
```

### Prerequisites

- A Nerd Font: optional, provides various icons
  - if you have it set vim.g.have_nerd_font in init.lua to true
- Clipboard tool
  - Linux - xclip
  - MacOS - xsel
  - Windows - win32yank
- Command Utils
  - git
  - make
  - unzip
  - C Compiler (gcc)
  - ripgrep - Used by Telescope to recursively search directories with grep.
  - fzf - Fuzzy finder
- Language Setup:
  - If want to write Typescript, you need npm
  - If want to write Golang, you will need go
  - etc.

### Recommendations

- zoxide - cd replacement

## todo

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
