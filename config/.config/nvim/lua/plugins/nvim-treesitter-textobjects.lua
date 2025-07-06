return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {"nvim-treesitter/nvim-treesitter"},
  config = function ()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            ["am"] = { query = "@function.outer", desc = "Select [A]round [M]ethod" },
            ["im"] = { query = "@function.inner", desc = "Select [I]inside [M]ethod" },
            ["a/"] = { query = "@comment.outer", desc = "Select [A]round comment" },
            ["i/"] = { query = "@comment.inner", desc = "Select [I]inside comment" },
            ["ac"] = { query = "@class.outer", desc = "Select [A]round [C]lass" },
            ["ic"] = { query = "@class.inner", desc = "Select [I]side [C]lass" },
            ["aa"] = { query = "@parameter.outer", desc = "Select [A]round method [A]rgument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select [I]side method [A]rgument" },
            ["aS"] = { query = "@local.scope", desc = "Select [A]round [S]cope" },
          },
          include_surrounding_whitespace = false,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]/"] = "@comment.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[/"] = "@comment.outer",
          },
        },
      }
    })
  end
}
