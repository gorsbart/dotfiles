return {
  "rcarriga/nvim-notify",
  opts = {},
  -- stylua: ignore
  keys = { },
  config = function ()
      require("notify").setup()
      vim.notify = require("notify")
  end
}
