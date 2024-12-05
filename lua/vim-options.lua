vim.cmd("set expandtab")

vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.showtabline = 2

-- Customize LSP references color
vim.cmd [[
  highlight LspReferenceText guibg=#3b4252 guifg=NONE gui=NONE
  highlight LspReferenceRead guibg=#3b4252 guifg=NONE gui=NONE
  highlight LspReferenceWrite guibg=#bf616a guifg=NONE gui=NONE
]]

vim.o.updatetime = 200 -- Default is 4000ms, set to 300ms for quicker response

