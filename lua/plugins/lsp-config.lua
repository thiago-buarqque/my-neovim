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
                    "jdtls"
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

            -- LSP configurations
            lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach, -- Attach the function here
            })
            lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.eslint.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.marksman.setup({ capabilities = capabilities, on_attach = on_attach })
            lspconfig.jdtls.setup({ capabilities = capabilities, on_attach = on_attach })
        end
    },

    -- {
    --     'mfussenegger/nvim-jdtls',
    --     config = function()
    --         local jdtls = require('jdtls')
    --         local mason_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
    --         local config = {
    --             cmd = { mason_path .. '/bin/jdtls' },
    --             root_dir = require('jdtls.setup').find_root({ 'gradlew', '.git', 'mvnw' }),
    --             settings = {
    --                 java = {
    --                     configuration = {
    --                         runtimes = {
    --                             {
    --                                 name = "JavaSE-17",
    --                                 path = "/opt/java/jdk17",
    --                             },
    --                             {
    --                                 name = "JavaSE-8",
    --                                 path = "/opt/java/jdk8",
    --                             },
    --                         }
    --                     }
    --                 }
    --             },
    --             init_options = {
    --                 bundles = {}
    --             }
    --         }
    --
    --         jdtls.start_or_attach(config)
    --     end
    -- }
}
