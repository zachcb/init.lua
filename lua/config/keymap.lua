local vim = vim
local opt = vim.opt
local o = vim.o
local g = vim.g

vim.o.statuscolumn = "%s %l %r"

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec('"normal! \\<RightMouse>"')

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })



-- Duplicate a line and comment out the first line
vim.keymap.set("n", "yc", "yygccp")

-- Move selected lines with shift+j or shift+k
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Alt + jk to move line up/down
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
vim.keymap.set(
    "i",
    "<A-j>",
    "<Esc>:m .+1<cr>==gi",
    { noremap = true, silent = true, desc = "Move line down (insert mode)" }
)
vim.keymap.set(
    "i",
    "<A-k>",
    "<Esc>:m .-2<cr>==gi",
    { noremap = true, silent = true, desc = "Move line up (insert mode)" }
)
vim.keymap.set("x", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move block up" })
