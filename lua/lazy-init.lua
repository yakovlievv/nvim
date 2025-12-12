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

local is_minimal = vim.env.NVIM_REMOTE == "1" or vim.fn.filereadable(vim.fn.expand("~/.remote_nvim")) == 1

local spec = {
	{ import = "core-plugins" },
	is_minimal and nil or { import = "plugins" },
}

require("lazy").setup({
	spec = spec,
	ui = { border = "rounded" },
	install = { colorscheme = { "nightfly" } },
	change_detection = { enabled = true, notify = false },
	checker = { enabled = true, notify = false },
})
