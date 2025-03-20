require("config")

local on_attach = function (event)
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

end

local client = vim.lsp.start_client {
  name = "edulsp",
  cmd = { "/home/bart/Projects/edulsp/main"},
  on_attach = on_attach
}

if not client then
  vim.notify "given client is no good"
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function ()
    vim.lsp.buf_attach_client(0, client)
  end
})
