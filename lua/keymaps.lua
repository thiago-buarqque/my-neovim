---@diagnostic disable-next-line: lowercase-global
function inputreplace()
    local old_word = vim.fn.input("Old word: ")
    local new_word = vim.fn.input("New word: ")

    vim.cmd("%s/" .. old_word .. "/" .. new_word .. "/gc")
end

local map = vim.keymap.set

-- Create a replace shortcut
map("n", "<leader>h", ":lua inputreplace()<CR>", { noremap = true, silent = true })

-- Map Tab to indent the current line or selected lines in visual mode
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Open buffer on the right side
-- vim.keymap.set("n", "<M-?>", ":vnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-?>", ":rightbelow vnew<CR>", { noremap = true, silent = true })

-- Map Shift+Tab to un-indent the current line or selected lines in visual mode
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Keymaps I got from NVChad

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
-- map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })
