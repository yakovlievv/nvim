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
	event = "BufAdd",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<C-b>h", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "<C-b>l", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
	},
	opts = {
		options = {
            -- stylua: ignore
            close_command = function(n) Snacks.bufdelete(n) end,
            -- stylua: ignore
            right_mouse_command = function(n) Snacks.bufdelete(n) end,
			always_show_bufferline = false,
			diagnostics = "nvim_lsp",
			offsets = {
				{
					filetype = "neo-tree",
                    -- stylua: ignore
                    -- text = function() 
                    --     return path_for_bufferline(vim.fn.bufnr()) 
                    -- end,
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
