return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults = vim.tbl_deep_extend("force", conf.defaults or {}, {
        file_ignore_patterns = { "**/node_modules", ".git", "**/build", "dist", "**/__pycache__", "**/target" },
      })

      return conf
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "java", "rust", "css", "typescript", "properties", "json" } },
  },
}
