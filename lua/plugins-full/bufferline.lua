local function path_for_bufferline(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if bufname == "" then
		return "Neo-tree"
	end
	local home = vim.env.HOME
	if bufname:sub(1, #home) == home then
		bufname = "~" .. bufname:sub(#home + 1)
	end
	return bufname
end

return {
	"akinsho/bufferline.nvim",
	event = "BufReadPost",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<C-b>h", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "<C-b>l", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
	},
	opts = {
		options = {
			show_buffer_close_icons = false,
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			right_mouse_command = function(n)
				Snacks.bufdelete(n)
			end,
			always_show_bufferline = false,
			diagnostics = "nvim_lsp",
			-- Show only highest priority diagnostic like LazyVim
			diagnostics_indicator = function(_, _, diag)
				local icons = _G.ICONS.diagnostics
				local ret = (diag.error and icons.error .. diag.error .. " " or "")
					.. (diag.warning and not diag.error and icons.warn .. diag.warning .. " " or "")
					.. (diag.info and not diag.error and not diag.warning and icons.info .. diag.info .. " " or "")
					.. (
						diag.hint
							and not diag.error
							and not diag.warning
							and not diag.info
							and icons.hint .. diag.hint
						or ""
					)
				return vim.trim(ret)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neotree",
					highlight = "Directory",
					text_align = "left",
				},
				{
					filetype = "snacks_layout_box",
				},
			},
		},
	},
}
