return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
    },
    config = function ()

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup{
        automatic_enable = {
          exclude = {
            "jdtls"
          }
        }
      }


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
