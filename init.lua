local vim = vim

-- I forget what this does
if vim.loader then
  vim.loader.enable()
end

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  spec = {
    { import = "plugins/enabled" },
    { import = "plugins/cheatsheet" },
    { import = "plugins/cmp" },
    { import = "plugins/colorscheme" },
    { import = "plugins/comment" },
    { import = "plugins/edgy" },
    -- { import = 'plugins/formatting' },
    { import = "plugins/harpoon" },
    { import = "plugins/lsp" },
    { import = "plugins/markview" },
    { import = "plugins/menu" },
    -- { import = "plugins/nvim-lint" },
    { import = "plugins/nvim-tree" },
    { import = "plugins/rzip" },
    { import = "plugins/snacks" },
    { import = "plugins/telescope" },
    { import = "plugins/trouble" },
    { import = "plugins/typescript" },
    { import = "plugins/which-key" },
    { import = "plugins/oil" },
    { import = "plugins/bufferline" },
    { import = "plugins/nvim-dap" },
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },

  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },

  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
