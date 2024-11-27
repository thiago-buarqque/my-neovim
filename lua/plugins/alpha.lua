return {
    "goolord/alpha-nvim",
    config = function()
        -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
        local present, alpha = pcall(require, "alpha")
        if not present then
            return
        end

        local screen = require("alpha-screens.neo-bee")

        alpha.setup(screen())
    end,
}
