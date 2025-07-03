return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    'saghen/blink.cmp'
  },
  cmd = "Copilot",
  event = "VeryLazy",
  config = function()
    require("copilot").setup({
      copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v20.19.2/bin/node", -- Node.js version must be > 20
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
