return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
	},
	keys = {
		{ "]h", function() require("gitsigns").nav_hunk("next", { count = vim.v.count1 }) end, desc = "Next Hunk" },
		{ "[h", function() require("gitsigns").nav_hunk("prev", { count = vim.v.count1 }) end, desc = "Prev Hunk" },
		{ "<leader>hs", function() require("gitsigns").stage_hunk() end,                                              desc = "Stage Hunk" },
		{ "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "Stage Hunk" },
		{ "<leader>hr", function() require("gitsigns").reset_hunk() end,                                              desc = "Reset Hunk" },
		{ "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "Reset Hunk" },
		{ "<leader>hS", function() require("gitsigns").stage_buffer() end,         desc = "Stage Buffer" },
		{ "<leader>hR", function() require("gitsigns").reset_buffer() end,         desc = "Reset Buffer" },
		{ "<leader>hp", function() require("gitsigns").preview_hunk_inline() end,  desc = "Preview Hunk" },
		{ "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line" },
		{ "<leader>hd", function() require("gitsigns").diffthis() end,             desc = "Diff This" },
		{ "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" },            desc = "Inside Hunk" },
	},
}
