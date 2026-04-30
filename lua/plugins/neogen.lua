return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	keys = {
		{
			"<leader>cgg",
			function()
				require("neogen").generate()
			end,
			desc = "Generate docstring",
		},
		{
			"<leader>cgf",
			function()
				require("neogen").generate({ type = "func" })
			end,
			desc = "Generate func docstring",
		},
		{
			"<leader>cgc",
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Generate class docstring",
		},
	},
	opts = {
		snippet_engine = "luasnip",
		languages = {
			python = {
				template = {
					annotation_convention = "google_docstrings",
				},
			},
		},
	},
}
