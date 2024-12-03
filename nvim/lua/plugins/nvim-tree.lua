return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { '|', ':NvimTreeToggle<CR>', desc = 'NvimTree toggle reveal', silent = true },
  },
  config = function()
    require("nvim-tree").setup {
      update_focused_file = {
        enable = true,
      }
    }
  end,
}

--Find and Focus Directory (with Telescope) 
-- function find_directory_and_focus()
--   local actions = require("telescope.actions")
--   local action_state = require("telescope.actions.state")
--
--   local function open_nvim_tree(prompt_bufnr, _)
--     actions.select_default:replace(function()
--       local api = require("nvim-tree.api")
--
--       actions.close(prompt_bufnr)
--       local selection = action_state.get_selected_entry()
--       api.tree.open()
--       api.tree.find_file(selection.cwd .. "/" .. selection.value)
--     end)
--     return true
--   end
--
--   require("telescope.builtin").find_files({
--     find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
--     attach_mappings = open_nvim_tree,
--   })
-- end
--
-- vim.keymap.set("n", "fd", find_directory_and_focus)
