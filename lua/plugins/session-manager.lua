return {
    "Shatur/neovim-session-manager",
    config = function()
        local Path = require("plenary.path")
        local config = require("session_manager.config")
        local session_manager = require("session_manager")

        -- Helper functions to create directory-specific session filenames
        local function dir_to_session_filename(dir)
            dir = dir or vim.fn.getcwd()
            local encoded_dir = dir:gsub("/", "%%") -- Encode / as % to create a unique filename
            return Path:new(vim.fn.stdpath("data"), "sessions", encoded_dir .. ".vim")
        end

        local function session_filename_to_dir(filename)
            local basename = Path:new(filename):name():gsub("%%", "/"):gsub("%.vim$", "")
            return Path:new(vim.fn.stdpath("data"), "sessions", basename)
        end

        -- Session Manager setup
        session_manager.setup({
            sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- Session files directory
            session_filename_to_dir = session_filename_to_dir,           -- Converts filename to directory
            dir_to_session_filename = dir_to_session_filename,           -- Converts directory to session filename
            autoload_mode = config.AutoloadMode.CurrentDir,              -- Load the session based on current directory
            autosave_last_session = true,                                -- Autosave last session
            autosave_ignore_not_normal = true,                           -- Ignore non-writable buffers
            autosave_ignore_dirs = {},                                   -- Directories to ignore for autosave
            autosave_ignore_filetypes = { "gitcommit", "gitrebase" },    -- Ignore certain file types
            autosave_ignore_buftypes = {},                               -- Ignore certain buffer types
            autosave_only_in_session = false,                            -- Always autosave sessions
            max_path_length = 80,                                        -- Display path length limit
        })
    end,
}
