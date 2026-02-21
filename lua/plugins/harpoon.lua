return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		-- settings = {
		-- 	save_on_toggle = true,
		-- },
	},
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon add" })
		vim.keymap.set("n", "<leader>H", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon menu" })

		vim.keymap.set("n", "<M-1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<M-2>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<M-3>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<M-4>", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<M-5>", function()
			harpoon:list():select(5)
		end)
		vim.keymap.set("n", "<M-6>", function()
			harpoon:list():select(6)
		end)
		vim.keymap.set("n", "<M-7>", function()
			harpoon:list():select(7)
		end)
		vim.keymap.set("n", "<M-8>", function()
			harpoon:list():select(8)
		end)
	end,
}
