return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope.builtin")

			vim.keymap.set("n", "<leader>p", telescope.find_files, {})
			vim.keymap.set("n", "<leader>f", telescope.live_grep, {})
			vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
			vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
			vim.keymap.set(
				"n",
				"<leader>fz",
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "telescope find in current buffer" }
			)
            vim.keymap.set("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
			vim.keymap.set("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })

			-- Map <leader>r to find references using LSP with Telescope
			vim.keymap.set("n", "<M-r>", telescope.lsp_references, { noremap = true, silent = true })

			-- Map <leader>d to go to implementation
			vim.keymap.set("n", "<C-F12>", telescope.lsp_implementations, { noremap = true, silent = true })

			-- Optionally, Map <leader>D to go to declaration if desired
			vim.keymap.set("n", "<F12>", telescope.lsp_definitions, { noremap = true, silent = true })

            -- Map Alt+Shift+O to list file symbols
            vim.keymap.set('n', '<M-O>', telescope.lsp_document_symbols, { noremap = true, silent = true, desc = "List file symbols" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

						-- pseudo code / specification for writing custom displays, like the one
						-- for "codeactions"
						-- specific_opts = {
						--   [kind] = {
						--     make_indexed = function(items) -> indexed_items, width,
						--     make_displayer = function(widths) -> displayer
						--     make_display = function(displayer) -> function(e)
						--     make_ordinal = function(e) -> string
						--   },
						--   -- for example to disable the custom builtin "codeactions" display
						--      do the following
						--   codeactions = false,
						-- }
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
