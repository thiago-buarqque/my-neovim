return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons", -- For icons
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "none",                      -- Show buffer numbers (optional)
                diagnostics = "nvim_lsp",             -- Show LSP diagnostics in tabs
                separator_style = "slant",            -- Choose "slant", "padded_slant", etc.
                show_buffer_close_icons = true,       -- Show close icons on buffers
                show_close_icon = false,              -- Disable close icon for tabline
                always_show_bufferline = true,        -- Always show the tabline
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
        })

        -- vim.keymap.set('n', '<leader><Tab>', ':BufferLineCycleNext<CR>', { desc = "Go to the next tab" })
        -- vim.keymap.set('n', '<leader><S-Tab>', ':BufferLineCyclePrev<CR>', { desc = "Go to the previous tab" })
        vim.keymap.set('n', '<leader>w', ':bdelete<CR>', { desc = "Close the current buffer" })
        vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { desc = "Go to buffer 1" })
        vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 2" })
        vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 3" })
        vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 4" })
        vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 5" })
        vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 6" })
    end
}

