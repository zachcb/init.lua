return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    -- servers = {
    --     eslint = {
    --         settings = {
    --             -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
    --             workingDirectories = { mode = "auto" },
    --         },
    --     },
    -- },

    opts = {
        -- tsserver = {
        --     root_dir = function(...)
        --         return require("lspconfig.util").root_pattern(".git")(...)
        --     end,
        --     single_file_support = false,
        --     settings = {
        --         typescript = {
        --             inlayHints = {
        --                 includeInlayParameterNameHints = "literal",
        --                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --                 includeInlayFunctionParameterTypeHints = true,
        --                 includeInlayVariableTypeHints = false,
        --                 includeInlayPropertyDeclarationTypeHints = true,
        --                 includeInlayFunctionLikeReturnTypeHints = true,
        --                 includeInlayEnumMemberValueHints = true,
        --             },
        --         },
        --         javascript = {
        --             inlayHints = {
        --                 includeInlayParameterNameHints = "all",
        --                 includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --                 includeInlayFunctionParameterTypeHints = true,
        --                 includeInlayVariableTypeHints = true,
        --                 includeInlayPropertyDeclarationTypeHints = true,
        --                 includeInlayFunctionLikeReturnTypeHints = true,
        --                 includeInlayEnumMemberValueHints = true,
        --             },
        --         },
        --     },
        -- },
        html = {},
    },

    -- setup = {
    --     eslint = function()
    --       local function get_client(buf)
    --         return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
    --       end
    
    --       local formatter = LazyVim.lsp.formatter({
    --         name = "eslint: lsp",
    --         primary = false,
    --         priority = 200,
    --         filter = "eslint",
    --       })

    --       lsconf.eslint.setup({
    --         settings = {
    --             workingDirectory = { mode = 'location' },
    --         },
    --         root_dir = lsp_util.find_git_ancestor,
    --     })
    
    --       -- Use EslintFixAll on Neovim < 0.10.0
    --       if not pcall(require, "vim.lsp._dynamic") then
    --         formatter.name = "eslint: EslintFixAll"
    --         formatter.sources = function(buf)
    --           local client = get_client(buf)
    --           return client and { "eslint" } or {}
    --         end
    --         formatter.format = function(buf)
    --           local client = get_client(buf)
    --           if client then
    --             local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
    --             if #diag > 0 then
    --               vim.cmd("EslintFixAll")
    --             end
    --           end
    --         end
    --       end

    --       formatter.eslint.setup {
    --         root_dir = lspconfig_util.find_git_ancestor
    --       }
    
    --       -- register the formatter with LazyVim
    --       LazyVim.format.register(formatter)
    --     end,
    --   },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())


        -- lsconf.eslint.setup({
        --     settings = {
        --         workingDirectory = { mode = 'location' },
        --     },
        --     root_dir = lsp_util.find_git_ancestor,
        -- })

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "cssls",
                "dockerls",
                "eslint",
                "biome",
                "tsserver",
                "html",
                "lua_ls",
                "rust_analyzer",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0

                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

-- return {
-- 	-- tools
-- 	{
-- 		"williamboman/mason.nvim",
-- 		opts = function(_, opts)
-- 			vim.list_extend(opts.ensure_installed, {
-- 				"stylua",
-- 				"selene",
-- 				"luacheck",
-- 				"shellcheck",
-- 				"shfmt",
-- 				"tailwindcss-language-server",
-- 				"typescript-language-server",
-- 				"css-lsp",
-- 			})
-- 		end,
-- 	},

-- 	-- lsp servers
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		init = function()
-- 			local keys = require("lazyvim.plugins.lsp.keymaps").get()
-- 			keys[#keys + 1] = {
-- 				"gd",
-- 				function()
-- 					-- DO NOT RESUSE WINDOW
-- 					require("telescope.builtin").lsp_definitions({ reuse_win = false })
-- 				end,
-- 				desc = "Goto Definition",
-- 				has = "definition",
-- 			}
-- 		end,
-- 		opts = {
-- 			inlay_hints = { enabled = false },
-- 			---@type lspconfig.options
-- 			servers = {
-- 				cssls = {},
-- 				tailwindcss = {
-- 					root_dir = function(...)
-- 						return require("lspconfig.util").root_pattern(".git")(...)
-- 					end,
-- 				},
-- 				tsserver = {
-- 					root_dir = function(...)
-- 						return require("lspconfig.util").root_pattern(".git")(...)
-- 					end,
-- 					single_file_support = false,
-- 					settings = {
-- 						typescript = {
-- 							inlayHints = {
-- 								includeInlayParameterNameHints = "literal",
-- 								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayVariableTypeHints = false,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 								includeInlayEnumMemberValueHints = true,
-- 							},
-- 						},
-- 						javascript = {
-- 							inlayHints = {
-- 								includeInlayParameterNameHints = "all",
-- 								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
-- 								includeInlayFunctionParameterTypeHints = true,
-- 								includeInlayVariableTypeHints = true,
-- 								includeInlayPropertyDeclarationTypeHints = true,
-- 								includeInlayFunctionLikeReturnTypeHints = true,
-- 								includeInlayEnumMemberValueHints = true,
-- 							},
-- 						},
-- 					},
-- 				},
-- 				html = {},
-- 				yamlls = {
-- 					settings = {
-- 						yaml = {
-- 							keyOrdering = false,
-- 						},
-- 					},
-- 				},
-- 				lua_ls = {
-- 					-- enabled = false,
-- 					single_file_support = true,
-- 					settings = {
-- 						Lua = {
-- 							workspace = {
-- 								checkThirdParty = false,
-- 							},
-- 							completion = {
-- 								workspaceWord = true,
-- 								callSnippet = "Both",
-- 							},
-- 							misc = {
-- 								parameters = {
-- 									-- "--log-level=trace",
-- 								},
-- 							},
-- 							hint = {
-- 								enable = true,
-- 								setType = false,
-- 								paramType = true,
-- 								paramName = "Disable",
-- 								semicolon = "Disable",
-- 								arrayIndex = "Disable",
-- 							},
-- 							doc = {
-- 								privateName = { "^_" },
-- 							},
-- 							type = {
-- 								castNumberToInteger = true,
-- 							},
-- 							diagnostics = {
-- 								disable = { "incomplete-signature-doc", "trailing-space" },
-- 								-- enable = false,
-- 								groupSeverity = {
-- 									strong = "Warning",
-- 									strict = "Warning",
-- 								},
-- 								groupFileStatus = {
-- 									["ambiguity"] = "Opened",
-- 									["await"] = "Opened",
-- 									["codestyle"] = "None",
-- 									["duplicate"] = "Opened",
-- 									["global"] = "Opened",
-- 									["luadoc"] = "Opened",
-- 									["redefined"] = "Opened",
-- 									["strict"] = "Opened",
-- 									["strong"] = "Opened",
-- 									["type-check"] = "Opened",
-- 									["unbalanced"] = "Opened",
-- 									["unused"] = "Opened",
-- 								},
-- 								unusedLocalExclude = { "_*" },
-- 							},
-- 							format = {
-- 								enable = false,
-- 								defaultConfig = {
-- 									indent_style = "space",
-- 									indent_size = "2",
-- 									continuation_indent_size = "2",
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 			},
-- 			setup = {},
-- 		},
-- 	},
-- }
