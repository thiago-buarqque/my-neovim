return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            default_component_configs = {
                modified = {
                    symbol = "*",
                    highlight = "NeoTreeModified",
                },
            },
            window = {
                width = 40,
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                        "target",
                        "build",
                    },
                },
                follow_current_file = {
                    enabled = true,
                },
                group_empty_dirs = true,
                use_libuv_file_watcher = true,
            },
            open_on_setup = false,
            open_on_setup_file = false,
        })
        vim.keymap.set("n", "<M-p>", ":Neotree source=filesystem toggle left<CR>", { silent = true })
    end,
}
