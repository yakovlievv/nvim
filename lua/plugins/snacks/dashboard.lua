return {
	enabled = true,
	pane_gap = 4, -- empty columns between vertical panes
	preset = {
		keys = {
			{
				icon = " ",
				key = "f",
				desc = "Find File",
				action = ":lua Snacks.dashboard.pick('files')",
			},
			{
				icon = " ",
				key = "n",
				desc = "New File",
				action = ":ene | startinsert",
			},
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
				icon = " ",
				key = "g",
				desc = "Lazygit",
				action = ":lua Snacks.lazygit()",
			},
			{
				icon = "󰆍 ",
				key = "t",
				desc = "Terminal",
				action = ":lua Snacks.terminal.toggle(nil, {win={border='rounded'}})",
			},
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
		{ section = "startup" },
	},
}
