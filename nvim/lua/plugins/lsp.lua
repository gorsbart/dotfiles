return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function ()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
--                "gopls",
--                "clangd",
--                "cmake",
                "grammarly",
                "groovyls",
                "jsonls",
                "java_language_server",
                "ts_ls",
                "kotlin_language_server",
                "texlab",
                "marksman",
--                "jedi_language_server",
--                "sqls",
                "bashls",

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

        local kind_icons = {
          Text = "",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰇽",
          Variable = "󰂡",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰅲",
        }



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
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'buffer' },
            }),
            formatting = {
              format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                -- Source
                vim_item.menu = ({
                  buffer = "[Buf]",
                  nvim_lsp = "[LSP]",
                  luasnip = "[Snip]",
                  nvim_lua = "[Lua]",
                  latex_symbols = "[TeX]",
                })[entry.source.name]
                return vim_item
              end
            },
            experimental = {
              native_menu = false,
              ghost_text = true
            }
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

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
          callback = function(event)
            local builtin = require("telescope.builtin")

            vim.keymap.set('n', 'gr', builtin.lsp_references, {buffer = event.buf, desc = 'LSP: [G]o to [R]eferences'})
            vim.keymap.set('n', 'gd', builtin.lsp_definitions, {buffer = event.buf, desc = 'LSP: [G]o to [D]efinitions'})
            vim.keymap.set('n', 'gI', builtin.lsp_definitions, {buffer = event.buf, desc = 'LSP: [G]o to [I]mplementations'})
            vim.keymap.set('n', '<leader>D', builtin.lsp_type_definitions, {buffer = event.buf, desc = 'LSP: Type [D]efinitions'})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer = event.buf, desc = '[R]e[n]ame'})
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer = event.buf, desc = '[G]oto [D]eclaration'})

            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, {buffer = event.buf, desc = 'LSP: [K]now something about whats under the cursor'})
            vim.keymap.set('n', '<leader>w', function() vim.lsp.buf.workspace_symbol() end, {buffer = event.buf, desc = 'LSP: [W]orkspace symbol'})
            vim.keymap.set('n', '<leader>f', function() vim.diagnostic.open_float() end, {buffer = event.buf, desc = 'LSP: Open [F]loat'})
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, {buffer = event.buf, desc = 'LSP: Next [D]iagnostics'})
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, {buffer = event.buf, desc = 'LSP: Previous [D]iagnostics'})
            vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, {buffer = event.buf, desc = 'LSP: [C]ode [A]ction'})
            vim.keymap.set('i', '<M-h>', function() vim.lsp.buf.signature_help() end, {buffer = event.buf, desc = 'LSP: Signature [H]elp'})
            vim.keymap.set('n', '<M-h>', function() vim.lsp.buf.signature_help() end, {buffer = event.buf, desc = 'LSP: Signature [H]elp'})
          end,
        })
    end
}
