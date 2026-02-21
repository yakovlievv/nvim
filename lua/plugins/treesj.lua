return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>m",
			function()
				require("treesj").toggle()
			end,
			desc = "TreeSJ toggle",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup()
	end,
}
