return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{ "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add" },
		{ "<leader>H", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
		{ "<leader>1", function() require("harpoon"):list():select(1) end },
		{ "<leader>2", function() require("harpoon"):list():select(2) end },
		{ "<leader>3", function() require("harpoon"):list():select(3) end },
		{ "<leader>4", function() require("harpoon"):list():select(4) end },
		{ "<leader>5", function() require("harpoon"):list():select(5) end },
		{ "<leader>6", function() require("harpoon"):list():select(6) end },
		{ "<leader>7", function() require("harpoon"):list():select(7) end },
		{ "<leader>8", function() require("harpoon"):list():select(8) end },
	},
	config = function()
		require("harpoon"):setup({
			menu = { width = vim.api.nvim_win_get_width(0) - 4 },
		})
	end,
}
