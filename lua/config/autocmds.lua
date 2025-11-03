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
