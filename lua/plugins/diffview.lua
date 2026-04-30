return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
		{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			default = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
			merge_tool = {
				layout = "diff3_mixed",
				disable_diagnostics = true,
			},
		},
		file_panel = {
			listing_style = "tree",
			tree_options = {
				flatten_dirs = true,
				folder_statuses = "only_folded",
			},
		},
		hooks = {
			diff_buf_read = function(bufnr)
				vim.diagnostic.enable(false, { bufnr = bufnr })
				vim.opt_local.spell = false
			end,
		},
	},
}
