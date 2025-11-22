vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("my.yank-highlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local yazi_group = vim.api.nvim_create_augroup("my.yazi", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "my.yazi",
	group = yazi_group,
	desc = "Remove timeout inside yazi for instant <Esc> response",
	callback = function()
		vim.b.old_timeoutlen = vim.o.timeoutlen
		vim.o.timeoutlen = 0
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "yazi",
	group = yazi_group,
	desc = "Restore timeoutlen when leaving yazi buffer",
	callback = function()
		if vim.b.old_timeoutlen then
			vim.o.timeoutlen = vim.b.old_timeoutlen
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("my.markdown-wrap", { clear = true }),
	desc = "Enable wrap for all Markdown files",
	callback = function()
		vim.wo.wrap = true -- turn on line wrapping
		vim.wo.linebreak = true -- break lines at word boundaries (optional, nicer look)
	end,
})

local folds_group = vim.api.nvim_create_augroup("my.folds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = folds_group,
	desc = "Auto-save folds for each file",
	pattern = "*",
	command = "silent! mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = folds_group,
	desc = "Auto-load folds when reopening",
	pattern = "*",
	command = "silent! loadview",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.comments", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})
