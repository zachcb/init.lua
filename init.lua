if vim.loader then
  vim.loader.enable()
end

vim.print = _G.dd
vim.cmd([[set mouse=a]])

vim.o.statuscolumn = "%s %l %r"

require("config.vim")
require("config.lazy")

vim.opt.termguicolors = true
