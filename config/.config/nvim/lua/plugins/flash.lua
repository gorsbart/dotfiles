return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[S]eek with Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[S]eek with Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Seek with [R]emote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "[R]emote Treesitter Seeking with Flash" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  }
}
