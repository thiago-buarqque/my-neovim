require "nvchad.mappings"

vim.cmd([[
  augroup web_files
    autocmd!
    autocmd FileType html,css,typescript,typescriptreact,javascript,json,yaml,yml setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab
  augroup END
]])

vim.opt.clipboard = "unnamedplus"

vim.o.updatetime = 200
vim.opt.scrolloff = 999

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "<leader>e", "<ESC>")
map("n", "<M-p>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<M-[>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Line insertion
map('n', '<leader>o', ':put _<CR>', { noremap = true, silent = true, desc = "Add line below without insert"})
map('n', '<leader>O', ':put! _<CR>', { noremap = true, silent = true, desc = "Add line above without insert"})
-- tabufline
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "buffer new" })

-- Map Tab to indent the current line or selected lines in visual mode
map("n", "<Tab>", ">>", { noremap = true, silent = true, desc = "Add tab" })
map("n", "<S-Tab>", "<<", { noremap = true, silent = true, desc = "Remove tab" })

map("n", "<C-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<C-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<C-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- whichkey
map("n", "<leader>K", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

-- map("n", "<leader>k", function()
--   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
-- end, { desc = "whichkey query lookup" })

-- Navigate back and forward
map('n', '<M-Left>', '<C-o>', { desc = 'Go back in jump list' })
map('n', '<M-Right>', '<C-i>', { desc = 'Go forward in jump list' })

-- Automatically remove old jumps from list
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local jumplist, _ = vim.fn.getjumplist()
        local max_jumps = 30

        if #jumplist > max_jumps then
            for i = #jumplist, max_jumps + 1, -1 do
                table.remove(jumplist, i)
            end
            vim.fn.setjumplist(jumplist)
        end
    end
})

