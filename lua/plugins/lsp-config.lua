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
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({capabilities = capabilities})
            lspconfig.rust_analyzer.setup({capabilities = capabilities})
            lspconfig.cssls.setup({capabilities = capabilities})
            lspconfig.html.setup({capabilities = capabilities})
            lspconfig.eslint.setup({capabilities = capabilities})
            lspconfig.jsonls.setup({capabilities = capabilities})
            lspconfig.marksman.setup({capabilities = capabilities})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<C-space>', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
        end
    }
}
