return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        enabled = false,
      }
    }
  },
  -- stylua: ignore
  keys = {
    { ";", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[S]eek with Flash" },
    { "<M-;>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[S]eek with Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Seek with [R]emote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "[R]emote Treesitter Seeking with Flash" },
    { "<c-;>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  }
}


