-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Setup Lazy

require("lazy").setup("plugins")

-- Configure Alpha to load on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- If no files are opened, show Alpha
		if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) == -1 then
			require("alpha").start()
		end
	end,
})

