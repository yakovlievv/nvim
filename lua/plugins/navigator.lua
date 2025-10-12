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
		{ "<m-h>", "<cmd>TmuxNavigateLeft<cr>" },
		{ "<m-j>", "<cmd>TmuxNavigateDown<cr>" },
		{ "<m-k>", "<cmd>TmuxNavigateUp<cr>" },
		{ "<m-l>", "<cmd>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
	},
	config = function()
		-- Disable default tmux navigator mappings
		vim.g.tmux_navigator_no_mappings = 1
		local opts = { silent = true, noremap = true }

		-- Set custom mappings in normal mode
		vim.keymap.set("n", "<m-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
		vim.keymap.set("n", "<m-j>", "<cmd>TmuxNavigateDown<CR>", opts)
		vim.keymap.set("n", "<m-k>", "<cmd>TmuxNavigateUp<CR>", opts)
		vim.keymap.set("n", "<m-l>", "<cmd>TmuxNavigateRight<CR>", opts)
	end,
}
