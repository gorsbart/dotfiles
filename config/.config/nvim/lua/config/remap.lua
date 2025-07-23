vim.g.mapleader = " "


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>d", "\"_d")

vim.keymap.set("i", "<C-e>", "<END>")

vim.keymap.set("n", "<leader>q", function ()
  local timeout = vim.o.timeoutlen
  local interval = 10
  local waited = 0
  local key = nil

  vim.api.nvim_echo({ { "Waiting for register key...", "Question" } }, false, {})
  -- Wait until key is pressed or timeout expires
  while waited < timeout do
    key = vim.fn.getchar(0)  -- non-blocking getchar
    if key ~= 0 then break end
    vim.cmd.sleep{args = {interval .. "m"}}
    waited = waited + interval
  end

  if key == nil or key == 0 or key == 27 then
    vim.api.nvim_echo({ { "", "Question" } }, false, {})
    return
  end

  local reg = vim.fn.nr2char(key)
  if not reg:match('^[0-9a-zA-Z#=*+/"-]$') then
    vim.notify("Invalid register: " .. reg, vim.log.levels.WARN)
    return
  end
  vim.ui.input({ prompt = 'Edit value in register ' .. reg .. ':', default=vim.fn.getreg(reg), cancelreturn=vim.fn.getreg(reg) }, function(input)
    vim.fn.setreg(reg, input)
  end)
end
, {desc = 'Register edit'})






