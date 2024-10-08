-- Colorscheme = 'github_dimmed'
Colorscheme = 'dracula'
-- Colorscheme = 'github_light'
Font = 'FiraCode Nerd Font'
TabSize = 2

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

Lua = {}
Lua.formatLineLength = 80

Term = {}
Term.shell = vim.o.shell -- or a string with the path to a shell binary
Term.size = 15
Term.shade = true
Term.direction = 'horizontal' -- horizontal, vertical, window, or float
Term.floatBorder = 'shadow' -- single, double, shadow, or curved

LSP = {}
LSP.format_on_save = true

LSP.Servers = {
  efm = {
    format = true,
  },
  eslint = {
    format = true,
    workingDirectories = { mode = "auto" },
  },
  jsonls = {
    format = false,
  },
  lua_ls = {
    format = false,
  },
  html = true,
  tsserver = {
    format = true,
  },
}

function LSP.can_client_format(client_name)
  if LSP.Servers[client_name] == true then
    return true
  end

  if LSP.Servers[client_name] then
    return (LSP.Servers[client_name].format == true)
  end

  return false
end
