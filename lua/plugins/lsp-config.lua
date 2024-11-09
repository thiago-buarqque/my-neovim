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
                    "jdtls",         -- Java
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
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.cssls.setup({})
            lspconfig.html.setup({})
            lspconfig.eslint.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.marksman.setup({})
            lspconfig.jdtls.setup({
                cmd = {
                    '/opt/java/jdk17/bin/java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.level=ALL',
                    '-Xms1g',
                    '-Xmx16g',
                    '-jar',
                    require('mason-registry').get_package('jdtls'):get_install_path() ..
                    '/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
                    '-configuration',
                    require('mason-registry').get_package('jdtls'):get_install_path() .. '/config_linux', -- or config_mac, config_win based on OS
                    '-data', vim.fn.stdpath('cache') .. '/java_workspace'
                },
                root_dir = require('lspconfig').util.root_pattern('.git', 'mvnw', 'gradlew'),
                settings = {
                    java = {
                        eclipse = { downloadSources = true },
                        configuration = { updateBuildConfiguration = "automatic" },
                        maven = { downloadSources = true },
                        gradle = { downloadSources = true },
                        implementationsCodeLens = { enabled = true },
                        referencesCodeLens = { enabled = true },
                        format = { enabled = true },
                        import = {
                            gradle = { enabled = true },
                            maven = { enabled = true }
                        }
                    },
                },
            })
            --lspconfig.lua_ls.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<C-space>', vim.lsp.buf.code_action, {})
        end
    }
}
