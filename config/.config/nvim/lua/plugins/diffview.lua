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
  end
}
