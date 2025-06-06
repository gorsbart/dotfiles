return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} }, 'nvim-telescope/telescope.nvim' },
  config = function ()

      local fzf_lua = require('fzf-lua')
      local oil = require("oil")
      oil.setup({
          default_file_explorer = true,
          skip_confirm_for_simple_edits = true,
          delete_to_trash = true,
          watch_for_changes = true,
          keymaps = {
                ["<M-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<leader>shf"] = { callback = function (bufnr)
                    fzf_lua.files({ cwd = oil.get_current_dir(bufnr) })
                end, desc = "[S]earch [H]ere for [F]iles"},
                ["<leader>shi"] = { callback = function (bufnr)
                    fzf_lua.live_grep_native({ cwd = oil.get_current_dir(bufnr) })
                end, desc = "[S]earch [H]ere [I]n files"},
                ["<leader>shg"] = { callback = function (bufnr)
                    fzf_lua.git_files({ cwd = oil.get_current_dir(bufnr) })
                end, desc = "[S]earch [H]ere for [G]it"},
          },
           git = {
            -- Return true to automatically git add/mv/rm files
            -- TODO try it in the future 
            add = function(path)
              return false
            end,
            mv = function(src_path, dest_path)
              return false
            end,
            rm = function(path)
              return false
            end,
        },
        view_options = {
          show_hidden = true,
        }
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
