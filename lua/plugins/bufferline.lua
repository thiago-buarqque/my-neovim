return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons", -- For file icons
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "slant",
				show_buffer_close_icons = true,
				show_close_icon = false,
				always_show_bufferline = true,
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

		local closed_buffers = {}

		local function close_current_buffer()
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname ~= "" then
				table.insert(closed_buffers, bufname)
			end
			vim.cmd("bdelete!")
		end

		local function reopen_last_closed_buffer()
			local last = table.remove(closed_buffers)
			if last then
				vim.cmd("edit " .. last)
			end
		end


		vim.keymap.set('n', '<C-T>', reopen_last_closed_buffer, { desc = "Reopen last closed buffer" })
		vim.keymap.set('n', '<leader>]', ':BufferLineCycleNext<CR>', { desc = "Go to the next tab" })
		vim.keymap.set('n', '<leader>[', ':BufferLineCyclePrev<CR>', { desc = "Go to the previous tab" })
		vim.keymap.set('n', '<leader>w', close_current_buffer, { desc = "Close the current buffer and save to history" })
		vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>', { desc = "Go to buffer 1" })
		vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>', { desc = "Go to buffer 2" })
		vim.keymap.set('n', '<leader>3', ':BufferLineGoToBuffer 3<CR>', { desc = "Go to buffer 3" })
		vim.keymap.set('n', '<leader>4', ':BufferLineGoToBuffer 4<CR>', { desc = "Go to buffer 4" })
		vim.keymap.set('n', '<leader>5', ':BufferLineGoToBuffer 5<CR>', { desc = "Go to buffer 5" })
		vim.keymap.set('n', '<leader>6', ':BufferLineGoToBuffer 6<CR>', { desc = "Go to buffer 6" })
		vim.keymap.set('n', '<leader>7', ':BufferLineGoToBuffer 7<CR>', { desc = "Go to buffer 7" })
		vim.keymap.set('n', '<leader>8', ':BufferLineGoToBuffer 8<CR>', { desc = "Go to buffer 8" })
		vim.keymap.set('n', '<leader>9', ':BufferLineGoToBuffer 9<CR>', { desc = "Go to buffer 9" })
	end
}
