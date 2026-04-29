return {
	"MagicDuck/grug-far.nvim",
	cmd = { "GrugFar", "GrugFarWithin" },
	opts = {
		headerMaxWidth = 80,
	},
	keys = {
		{
			"<leader>sg",
			function()
				require("grug-far").open()
			end,
			mode = { "n" },
			desc = "Search & Replace (grug-far)",
		},
		{
			"<leader>sg",
			function()
				require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
			end,
			mode = { "x" },
			desc = "Search & Replace selection (grug-far)",
		},
		{
			"<leader>sG",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			desc = "Search & Replace in file (grug-far)",
		},
	},
}
