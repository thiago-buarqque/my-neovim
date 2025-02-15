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

-- tabufline
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<C-tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<C-S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>w", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- whichkey
map("n", "<leader>K", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>k", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Navigate back and forward
vim.keymap.set('n', '<M-Left>', '<C-o>', { desc = 'Go back in jump list' })
vim.keymap.set('n', '<M-Right>', '<C-i>', { desc = 'Go forward in jump list' })

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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
