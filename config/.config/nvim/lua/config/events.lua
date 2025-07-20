vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function ()
    vim.highlight.on_yank()
  end,
})


vim.api.nvim_create_autocmd('FocusGained', {
  desc = "Read shada file for project or common",
  callback = function ()
    vim.cmd.sleep("100m")
    vim.cmd.rshada()
  end,
})


vim.api.nvim_create_autocmd('FocusLost', {
  desc = "Write shada file for project or common",
  callback = function ()
    vim.cmd.wshada()
  end,
})
