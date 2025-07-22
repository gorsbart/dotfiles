return {
  "sindrets/diffview.nvim",
  config = function ()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        merge_tool =  {
          layout = "diff3_horizontal",
        }
      },
    })
    vim.api.nvim_create_user_command('MergeviewOpen', 'DiffviewOpen -uno', {})

    
    vim.keymap.set('n', '<leader>hh', function ()
      local wordUnderCursor = vim.fn.expand("<cword>")
      vim.cmd.DiffviewOpen{args = {wordUnderCursor.."~.."..wordUnderCursor}}
    end, { desc = 'Quick check commit changes under the cursor in Diffview'})


  end
}
