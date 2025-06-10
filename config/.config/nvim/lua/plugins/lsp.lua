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
                "jsonls",
                "jdtls",
                "ts_ls",
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
                ["jdtls"] = function()
                  return true
                end,
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
            local fzf_lua = require('fzf-lua')

            vim.keymap.set('n', 'gr', fzf_lua.lsp_references, {buffer = event.buf, desc = 'LSP: [G]o to [R]eferences'})
            vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, {buffer = event.buf, desc = 'LSP: [G]o to [D]efinitions'})
            vim.keymap.set('n', 'gI', fzf_lua.lsp_implementations, {buffer = event.buf, desc = 'LSP: [G]o to [I]mplementations'})
            vim.keymap.set('n', '<leader>D', fzf_lua.lsp_typedefs, {buffer = event.buf, desc = 'LSP: Type [D]efinitions'})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer = event.buf, desc = '[R]e[n]ame'})
            vim.keymap.set('n', 'gD', fzf_lua.lsp_declarations, {buffer = event.buf, desc = '[G]oto [D]eclaration'})

            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, {buffer = event.buf, desc = 'LSP: [K]now something about whats under the cursor'})
            vim.keymap.set('n', '<leader>w', function() vim.lsp.buf.workspace_symbol() end, {buffer = event.buf, desc = 'LSP: [W]orkspace symbol'})
            vim.keymap.set('n', '<leader>f', function() vim.diagnostic.open_float() end, {buffer = event.buf, desc = 'LSP: Open [F]loat'})
            vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, {buffer = event.buf, desc = 'LSP: Next [D]iagnostics'})
            vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, {buffer = event.buf, desc = 'LSP: Previous [D]iagnostics'})
            -- vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, {buffer = event.buf, desc = 'LSP: [C]ode [A]ction'})
            vim.keymap.set('n', '<leader>ca', fzf_lua.lsp_code_actions, {buffer = event.buf, desc = 'LSP: [C]ode [A]ction'})
            vim.keymap.set('v', '<leader>ca', fzf_lua.lsp_code_actions, {buffer = event.buf, desc = 'LSP: [C]ode [A]ction'})
            vim.keymap.set('i', '<M-h>', function() vim.lsp.buf.signature_help() end, {buffer = event.buf, desc = 'LSP: Signature [H]elp'})
            vim.keymap.set('n', '<M-h>', function() vim.lsp.buf.signature_help() end, {buffer = event.buf, desc = 'LSP: Signature [H]elp'})
          end,
        })
    end
}
