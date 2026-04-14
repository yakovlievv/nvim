return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
				vim.notify("󱡁 Added to Harpoon", vim.log.levels.INFO)
			end,
			desc = "Harpoon add",
		},
		{
			"<leader>H",
			function()
				local h = require("harpoon")
				h.ui:toggle_quick_menu(h:list())
			end,
			desc = "Harpoon menu",
		},
		{
			"<C-1>",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<C-2>",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<C-3>",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<C-4>",
			function()
				require("harpoon"):list():select(4)
			end,
		},
		{
			"<C-5>",
			function()
				require("harpoon"):list():select(5)
			end,
		},
		{
			"<C-6>",
			function()
				require("harpoon"):list():select(6)
			end,
		},
		{
			"<C-7>",
			function()
				require("harpoon"):list():select(7)
			end,
		},
		{
			"<C-8>",
			function()
				require("harpoon"):list():select(8)
			end,
		},
	},
	config = function()
		require("harpoon"):setup()
	end,
}
