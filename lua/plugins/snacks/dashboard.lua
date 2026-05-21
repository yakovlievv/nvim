return {
	enabled = true,
	pane_gap = 4,
	preset = {
		keys = {
			{
				icon = " ",
				key = "f",
				desc = "Find File",
				action = ":lua Snacks.dashboard.pick('files')",
			},
			{
				icon = " ",
				key = "/",
				desc = "Grep",
				action = ":lua Snacks.dashboard.pick('grep')",
			},
			-- {
			-- 	icon = " ",
			-- 	key = "n",
			-- 	desc = "New File",
			-- 	action = ":ene | startinsert",
			-- },
			{
				icon = " ",
				key = "g",
				desc = "Lazygit",
				action = ":lua Snacks.lazygit()",
			},
			-- {
			-- 	icon = " ",
			-- 	key = "e",
			-- 	desc = "Oil Nvim",
			-- 	action = ":Oil",
			-- },
			-- {
			-- 	icon = " ",
			-- 	key = "r",
			-- 	desc = "Recent Files",
			-- 	action = ":lua Snacks.dashboard.pick('oldfiles')",
			-- },
			{
				icon = "󰒲 ",
				key = "l",
				desc = "Lazy",
				action = ":Lazy",
				enabled = package.loaded.lazy ~= nil,
			},
			{
				icon = " ",
				key = "q",
				desc = "Quit",
				action = ":qa",
			},
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
		{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		{
			function()
				if vim.fn.has("mac") == 1 then
					return {
						pane = 2,
						icon = "󰊢 ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}
				else
					return {}
				end
			end,
		},
		{ section = "startup" },
	},
}
