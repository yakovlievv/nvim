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
			{
				icon = " ",
				key = "n",
				desc = "New File",
				action = ":ene | startinsert",
			},
			{
				icon = " ",
				key = "y",
				desc = "Yazi",
				action = ":Yazi",
			},
			{
				icon = " ",
				key = "g",
				desc = "Lazygit",
				action = ":lua Snacks.lazygit()",
			},
			{
				icon = " ",
				key = "e",
				desc = "Oil Nvim",
				action = ":Oil",
			},
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
		{
			section = "terminal",
			cmd = 'fortune -s | cowsay | awk \'BEGIN{e=sprintf("%c",27); ftn=e"[38;2;203;166;247m"; cow=e"[38;2;127;132;156m"; rst=e"[0m"} {if(inc)print cow $0 rst; else print ftn $0 rst; if($0 ~ /^ *-+ *$/)inc=1}\'',
			ttl = 0,
			height = 15,
			padding = 1,
			indent = 4,
			pane = 2,
		},
		{ section = "startup" },
	},
}
