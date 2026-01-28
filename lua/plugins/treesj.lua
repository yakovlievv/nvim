return {
	"Wansmer/treesj",
	keys = {
		{
			"<leader>jm",
			function()
				require("treesj").toggle()
			end,
			desc = "TreeSJ toggle",
		},
		{
			"<leader>jj",
			function()
				require("treesj").join()
			end,
			desc = "TreeSJ join",
		},
		{
			"<leader>js",
			function()
				require("treesj").split()
			end,
			desc = "TreeSJ split",
		},
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup()
	end,
}
