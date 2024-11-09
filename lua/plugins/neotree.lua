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
                }
            },
            window = {
                width = 30
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules"
                    }
                },
                follow_current_file = {
                    enabled = true
                },
                group_empty_dirs = true,
                use_libuv_file_watcher = true
            }
        })
        vim.keymap.set('n', '<M-p>', ':Neotree filesystem reveal left<CR>')
    end
}
