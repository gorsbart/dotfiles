
vim.g.kitty_navigator_password = "neov!MremotekittycontrOOl"

vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "90"

vim.opt.splitright = true

vim.opt.foldenable = false

vim.opt.fillchars:append { diff = "╱" }

-- paste registers in terminal windows
vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })

-- Add your abbreviations in this dictionary
local abbreviations = {
  -- spelling
  teh = "the",
  -- expansions
  btw = "by the way",
  imo = "in my opinion",
  i19 = "internationalization",
  -- java
  pu = "public",
  st = "static",
  vo = "void",
  re = "return",
}

for abbr, expanded in pairs(abbreviations) do
  vim.cmd("iab " .. abbr .. " " .. expanded)
end
