return {
	"folke/snacks.nvim",
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			width = 60,
			pane_gap = 4, -- empty columns between vertical panes
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "y",
						desc = "Open Yazi",
						action = ":Yazi toggle",
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},

		explorer = { enabled = false },
		image = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = false },
		bufdelete = {
			enabled = true,
			config = function() end,
		},
		notifier = {
			enabled = true,
			config = function()
				-- Example keymap to open the notification history
				vim.keymap.set("n", "<leader>nh", function()
					require("snacks.notifier").show_history()
				end, { desc = "Show notification history" })
			end,
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 150 },
				easing = "linear",
			},
			-- filter = function(buf)
			-- 	return vim.g.snacks_scroll ~= false
			-- 		and vim.b[buf].snacks_scroll ~= false
			-- 		and vim.bo[buf].buftype ~= "terminal"
			-- end,
		},
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
}
