-- Configure Alpha to load on startup
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- If no files are opened, show Alpha
        if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) == -1 then
            require("alpha").start()
        end
    end,
})
