-- Yazi autocmds (move to autocmds.lua if re-enabled):
-- Note: BufLeave pattern should match on filetype, not buffer name.
-- Use a FileType autocmd to register a buffer-local BufLeave instead.
--
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "yazi",
-- 	group = vim.api.nvim_create_augroup("my.yazi", { clear = true }),
-- 	desc = "Remove timeout inside yazi for instant <Esc> response",
-- 	callback = function()
-- 		vim.b.old_timeoutlen = vim.o.timeoutlen
-- 		vim.o.timeoutlen = 0
-- 		vim.api.nvim_create_autocmd("BufLeave", {
-- 			buffer = 0,
-- 			callback = function()
-- 				if vim.b.old_timeoutlen then
-- 					vim.o.timeoutlen = vim.b.old_timeoutlen
-- 				end
-- 			end,
-- 		})
-- 	end,
-- })

return {
	"mikavilpas/yazi.nvim",
	version = "*",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		-- 👇 in this section, choose your own keymappings!
		{
			"<C-y>",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			-- Open in the current working directory
			"<leader>yc",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<leader>-",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = false,
		floating_window_scaling_factor = 0.93,
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			open_and_pick_window = "<c-o>",
		},
	},
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
