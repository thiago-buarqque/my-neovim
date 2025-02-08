return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",        -- Lua
					"rust_analyzer", -- Rust
					"cssls",         -- CSS and SCSS
					"html",
					"eslint",        -- JavaScript and TypeScript
					"jsonls",        -- JSON
					"marksman",      -- Markdown
					"ts_ls"
				}
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require("lspconfig")

			-- Define the on_attach function for all LSPs
			local on_attach = function(client, bufnr)
				-- Enable document highlighting if supported
				if client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd("CursorMoved", {
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Add key mappings
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set({ 'n', 'v' }, '<C-Space>', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
			end

			local setupConfig = { capabilities = capabilities, on_attach = on_attach };

			-- LSP configurations
			lspconfig.lua_ls.setup(setupConfig)
			lspconfig.rust_analyzer.setup(setupConfig)
			lspconfig.cssls.setup(setupConfig)
			lspconfig.html.setup(setupConfig)
			lspconfig.eslint.setup(setupConfig)
			lspconfig.jsonls.setup(setupConfig)
			lspconfig.marksman.setup(setupConfig)
			lspconfig.jdtls.setup(setupConfig)
			lspconfig.ts_ls.setup(setupConfig)
		end
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "jay-babu/mason-null-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "eslint_d" }
			})
		end
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	}
}
