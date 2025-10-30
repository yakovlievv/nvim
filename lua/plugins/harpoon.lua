return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>a", desc = "Harpoon add file" },
		{ "<leader>H", desc = "Harpoon menu toggle" },
		{ "<c-h>", desc = "Harpoon select 1" },
		{ "<c-j>", desc = "Harpoon select 2" },
		{ "<c-k>", desc = "Harpoon select 3" },
		{ "<c-l>", desc = "Harpoon select 4" },
		{ "<C-S-H>", desc = "Harpoon prev" },
		{ "<C-S-L>", desc = "Harpoon next" },
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>H", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<c-h>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<c-j>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<c-k>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<c-l>", function()
			harpoon:list():select(4)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-H>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-L>", function()
			harpoon:list():next()
		end)
	end,
}
