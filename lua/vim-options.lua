vim.cmd("set expandtab")

vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.g.mapleader = " "
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 999

-- Map Ctrl+Tab to behave like Ctrl+w for window commands
vim.api.nvim_set_keymap('n', '<A-[>', '<C-w>', { noremap = true, silent = true })


-- Map Ctrl+Tab, then Ctrl+Tab again to switch windows (like <C-w><C-w>)
vim.api.nvim_set_keymap('n', '<A-[><A-[>', '<C-w><C-w>', { noremap = true, silent = true })

-- Map Ctrl+Tab + q to close a split (like <C-w>q)
-- vim.api.nvim_set_keymap('n', '<C-Tab>q', '<C-w>q', { noremap = true })

-- Map Ctrl+Tab + o to close all other splits (like <C-w>o)
-- vim.api.nvim_set_keymap('n', '<C-Tab>o', '<C-w>o', { noremap = true })


-- Add these to your color customization section
vim.cmd [[
  highlight LspReferenceText guibg=#3b4252 guifg=NONE gui=NONE
  highlight LspReferenceRead guibg=#3b4252 guifg=NONE gui=NONE
  highlight LspReferenceWrite guibg=#bf616a guifg=NONE gui=NONE
]]

vim.o.updatetime = 200 -- Default is 4000ms, set to 300ms for quicker response

vim.keymap.set('n', ']]', function()
    vim.cmd('silent! normal! ]z')
    vim.cmd('normal! zz') -- Center the screen
end, { noremap = true, silent = true, desc = "Next usage" })

vim.keymap.set('n', '[[', function()
    vim.cmd('silent! normal! [z')
    vim.cmd('normal! zz') -- Center the screen
end, { noremap = true, silent = true, desc = "Previous usage" })
