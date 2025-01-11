return {
    "mfussenegger/nvim-lint",
    version = "*",
    lazy = false,
    config = function()
      local lint = require("lint")

      -- Set up linters for JavaScript, JavaScriptReact, TypeScript, TypeScriptReact, Vue, Svelte, and Astro
      lint.linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        vue = { "eslint" },
        svelte = { "eslint" },
        astro = { "eslint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      local eslint = lint.linters.eslint_d

      eslint.args = {
        "--no-warn-ignored", -- <-- this is the key argument
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
         return vim.api.nvim_buf_get_name(0)
        end,
      }

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint(nil, { ignore_errors = true })
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
}