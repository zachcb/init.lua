local vim = vim

-- I forget what this does
if vim.loader then
  vim.loader.enable()
end

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- I forget what this does
vim.print = _G.dd
vim.cmd([[set mouse=a]])

-- Import Vim config files
require("config.keymap")
require("config.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- latest stable release
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()

    os.exit(1)
  end
end

--- @diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require("lazy").setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  "nvim-tree/nvim-web-devicons",

  spec = {
    { import = "plugins" },
  },

  -- defaults = {
  --   -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
  --   -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
  --   lazy = false,
  --   -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
  --   -- have outdated releases, which may break your Neovim install.
  --   version = false, -- always use the latest git commit
  --   -- version = "*", -- try installing the latest stable version for plugins that support semver
  -- },

  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  -- performance = {
  --   rtp = {
  --     -- disable some rtp plugins
  --     disabled_plugins = {
  --       "gzip",
  --       -- "matchit",
  --       -- "matchparen",
  --       -- "netrwPlugin",
  --       "tarPlugin",
  --       "tohtml",
  --       "tutor",
  --       "zipPlugin",
  --     },
  --   },
  -- },
})


