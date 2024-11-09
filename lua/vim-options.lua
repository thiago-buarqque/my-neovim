vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.wo.relativenumber = true

-- Map Ctrl+Tab to behave like Ctrl+w for window commands
vim.api.nvim_set_keymap('n', '<A-[>', '<C-w>', { noremap = true, silent = true })


-- Map Ctrl+Tab, then Ctrl+Tab again to switch windows (like <C-w><C-w>)
vim.api.nvim_set_keymap('n', '<A-[><A-[>', '<C-w><C-w>', { noremap = true, silent = true })

-- Map Ctrl+Tab + q to close a split (like <C-w>q)
-- vim.api.nvim_set_keymap('n', '<C-Tab>q', '<C-w>q', { noremap = true })

-- Map Ctrl+Tab + o to close all other splits (like <C-w>o)
-- vim.api.nvim_set_keymap('n', '<C-Tab>o', '<C-w>o', { noremap = true })


