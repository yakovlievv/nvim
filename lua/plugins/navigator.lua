vim.g.tmux_navigator_no_mappings = 1

return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		-- <cmd> mappings run in any mode, so these work from normal, insert
		-- and terminal mode (e.g. the claudecode split) without escaping out.
		{ "<M-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "i", "t" } },
		{ "<M-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "i", "t" } },
		{ "<M-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "i", "t" } },
		{ "<M-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "i", "t" } },
	},
}
