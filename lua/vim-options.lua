-- vim.cmd("set expandtab")

vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.cmd([[
  augroup web_files
    autocmd!
    autocmd FileType html,css,typescript,typescriptreact,javascript,json,yaml,yml setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab
  augroup END
]])

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

vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { noremap = true, silent = true, desc = "Show diagnostics in floating window" })

vim.keymap.set('n', '<M-Left>', '<C-o>', { desc = 'Go back in jump list' })
vim.keymap.set('n', '<M-Right>', '<C-i>', { desc = 'Go forward in jump list' })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })

vim.keymap.set("n", "<Esc>", function()
	-- Get all open windows
	for _, win in pairs(vim.api.nvim_list_wins()) do
		-- Check if the window is floating
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.api.nvim_win_close(win, true)
			return -- Exit the function after closing the floating window
		end
	end
end, { noremap = true, silent = true, desc = "Close floating windows" })
