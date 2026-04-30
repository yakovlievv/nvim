return {
	"akinsho/git-conflict.nvim",
	version = "*",
	event = "BufReadPost",
	opts = {
		default_mappings = true,
		default_commands = true,
		disable_diagnostics = false,
		list_opener = function()
			Snacks.picker.qflist()
		end,
		highlights = {
			incoming = "DiffAdd",
			current = "DiffText",
		},
	},
	keys = {
		{ "]x",          "<Plug>(git-conflict-next-conflict)", desc = "Next Conflict" },
		{ "[x",          "<Plug>(git-conflict-prev-conflict)", desc = "Prev Conflict" },
		{ "<leader>gxo", "<Plug>(git-conflict-ours)",         desc = "Conflict: Keep Ours" },
		{ "<leader>gxt", "<Plug>(git-conflict-theirs)",       desc = "Conflict: Keep Theirs" },
		{ "<leader>gxb", "<Plug>(git-conflict-both)",         desc = "Conflict: Keep Both" },
		{ "<leader>gx0", "<Plug>(git-conflict-none)",         desc = "Conflict: Keep None" },
		{ "<leader>gxl", "<cmd>GitConflictListQf<cr>",        desc = "Conflict: List All" },
	},
}
