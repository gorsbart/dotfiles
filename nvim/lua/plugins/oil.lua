return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function ()
      require("oil").setup({
          default_file_explorer = true,
          skip_confirm_for_simple_edits = true,
          delete_to_trash = true,
          keymaps = {
                ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" }
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
      })
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
}
