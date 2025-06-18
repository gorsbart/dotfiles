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
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<M-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<M-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<M-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in a new tab" },
                ["<M-p>"] = "actions.preview",
                ["<M-c>"] = { "actions.close", mode = "n" },
                ["<M-l>"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
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
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
        }
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
