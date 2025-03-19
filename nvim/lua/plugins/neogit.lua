return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "ibhagwan/fzf-lua",              -- optional
    -- "echasnovski/mini.pick",         -- optional
  },
  config = function ()
      local neogit = require('neogit')
      neogit.setup {}
      vim.keymap.set('n', 'gS', function () neogit.open() end)
  end
}
