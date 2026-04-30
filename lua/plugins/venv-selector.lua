return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = "python",
	cmd = { "VenvSelect", "VenvSelectCached" },
	keys = {
		{ "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select python venv" },
		{ "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
	},
	opts = {
		settings = {
			options = {
				notify_user_on_venv_activation = true,
				-- pick up uv, poetry, pdm, pipenv, .venv, conda
				cached_venv_automatic_activation = true,
			},
		},
	},
}
