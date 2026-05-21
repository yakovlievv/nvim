return {
	"andymass/vim-matchup",
	event = "LazyFile",
	init = function()
		vim.g.matchup_treesitter_stopline = 500
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.g.matchup_matchparen_deferred = 1
		vim.g.matchup_surround_enabled = 1
	end,
	config = function()
		require("match-up").setup({
			treesitter = {
				stopline = 500,
			},
		})
	end,
}
