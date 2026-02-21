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
		end)
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

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
	-- keys = function()
	-- 	local keys = {
	-- 		{
	-- 			"<leader>h",
	-- 			function()
	-- 				require("harpoon"):list():add()
	-- 			end,
	-- 			desc = "Harpoon File",
	-- 		},
	-- 		{
	-- 			"<leader>H",
	-- 			function()
	-- 				local harpoon = require("harpoon")
	-- 				harpoon.ui:toggle_quick_menu(harpoon:list())
	-- 			end,
	-- 			desc = "Harpoon Quick Menu",
	-- 		},
	-- 		{
	-- 			"<C-h>",
	-- 			function()
	-- 				require("harpoon").list():select(1)
	-- 			end,
	-- 			desc = "Harpoon Quick Menu",
	-- 		},
	--
	-- 		{
	-- 			"<C-j>",
	-- 			function()
	-- 				require("harpoon").list():select(2)
	-- 			end,
	-- 			desc = "Harpoon Quick Menu",
	-- 		},
	--
	-- 		{
	-- 			"<C-k>",
	-- 			function()
	-- 				require("harpoon").list():select(3)
	-- 			end,
	-- 			desc = "Harpoon Quick Menu",
	-- 		},
	-- 		{
	-- 			"<C-l>",
	-- 			function()
	-- 				require("harpoon").list():select(4)
	-- 			end,
	-- 			desc = "Harpoon Quick Menu",
	-- 		},
	-- 	}
	--
	-- 	-- for i = 1, 9 do
	-- 	-- 	table.insert(keys, {
	-- 	-- 		"<leader>" .. i,
	-- 	-- 		function()
	-- 	-- 			require("harpoon"):list():select(i)
	-- 	-- 		end,
	-- 	-- 		desc = "Harpoon to File " .. i,
	-- 	-- 	})
	-- 	-- end
	-- 	return keys
}
