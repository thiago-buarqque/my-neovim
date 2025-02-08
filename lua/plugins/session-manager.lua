return {
    "Shatur/neovim-session-manager",
    config = function()
        local config = require("session_manager.config")
        local session_manager = require("session_manager")

        session_manager.setup({
            autoload_mode = config.AutoloadMode.CurrentDir,              -- Load the session based on current directory
            autosave_last_session = true,                                -- Autosave last session
        })
    end,
}
