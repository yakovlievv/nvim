-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	-- For preloading telescope stuff
-- 	callback = function()
-- 		local telescope = require("telescope")
-- 		pcall(telescope.load_extension, "fzf") -- pre-load extensions
--
-- 		-- Preload builtin modules without opening a buffer
-- 		pcall(require("telescope.builtin"))
-- 	end,
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Remove timeout inside yazi for instant <Esc> response
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yazi",
	callback = function()
		vim.b.old_timeoutlen = vim.o.timeoutlen
		vim.o.timeoutlen = 0
	end,
})

-- Restore timeoutlen when leaving yazi buffer
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "yazi",
	callback = function()
		if vim.b.old_timeoutlen then
			vim.o.timeoutlen = vim.b.old_timeoutlen
		end
	end,
})
