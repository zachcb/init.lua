-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        lazy = false,
        priority = 1000,
        enabled = true,
        init = function()
            vim.cmd.colorscheme 'dracula'
        end,
    },
}
