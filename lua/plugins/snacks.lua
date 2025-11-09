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

		picker = {
			enabled = true,
			opts = {
				sources = {},
				focus = "input",
				ui_select = true, -- replace `vim.ui.select` with the snacks picker
				formatters = {},
				previewers = {
					diff = {
						-- fancy: Snacks fancy diff (borders, multi-column line numbers, syntax highlighting)
						-- syntax: Neovim's built-in diff syntax highlighting
						-- terminal: external command (git's pager for git commands, `cmd` for other diffs)
						style = "fancy",
						cmd = { "delta" }, -- example for using `delta` as the external diff command
						---@type vim.wo?|{} window options for the fancy diff preview window
						wo = {
							breakindent = true,
							wrap = true,
							linebreak = true,
							showbreak = "",
						},
					},
					git = {
						args = {}, -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
					},
					file = {
						max_size = 1024 * 1024, -- 1MB
						max_line_length = 500, -- max line length
						ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
					},
					man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
				},
				toggles = {
					follow = "f",
					hidden = "h",
					ignored = "i",
					modified = "m",
					regex = { icon = "R", value = false },
				},
				win = {
					input = {
						keys = {
							-- to close the picker on ESC instead of going to normal mode,
							-- add the following keymap to your config
							-- ["<Esc>"] = { "close", mode = { "n", "i" } },
							["/"] = "toggle_focus",
							["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
							["<C-Up>"] = { "history_back", mode = { "i", "n" } },
							["<C-c>"] = { "cancel", mode = "i" },
							["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
							["<CR>"] = { "confirm", mode = { "n", "i" } },
							["<Down>"] = { "list_down", mode = { "i", "n" } },
							["<Esc>"] = "cancel",
							["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
							["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
							["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
							["<Up>"] = { "list_up", mode = { "i", "n" } },
							["<a-d>"] = { "inspect", mode = { "n", "i" } },
							["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
							["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
							["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
							["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
							["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
							["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
							["<c-a>"] = { "select_all", mode = { "n", "i" } },
							["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
							["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
							["<c-j>"] = { "list_down", mode = { "i", "n" } },
							["<c-k>"] = { "list_up", mode = { "i", "n" } },
							["<c-n>"] = { "list_down", mode = { "i", "n" } },
							["<c-p>"] = { "list_up", mode = { "i", "n" } },
							["<c-q>"] = { "qflist", mode = { "i", "n" } },
							["<c-s>"] = { "edit_split", mode = { "i", "n" } },
							["<c-t>"] = { "tab", mode = { "n", "i" } },
							["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
							["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
							["<c-r>#"] = { "insert_alt", mode = "i" },
							["<c-r>%"] = { "insert_filename", mode = "i" },
							["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
							["<c-r><c-f>"] = { "insert_file", mode = "i" },
							["<c-r><c-l>"] = { "insert_line", mode = "i" },
							["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
							["<c-r><c-w>"] = { "insert_cword", mode = "i" },
							["<c-w>H"] = "layout_left",
							["<c-w>J"] = "layout_bottom",
							["<c-w>K"] = "layout_top",
							["<c-w>L"] = "layout_right",
							["?"] = "toggle_help_input",
							["G"] = "list_bottom",
							["gg"] = "list_top",
							["j"] = "list_down",
							["k"] = "list_up",
							["q"] = "cancel",
						},
						b = {
							minipairs_disable = true,
						},
					},
					-- result list window
					list = {
						keys = {
							["/"] = "toggle_focus",
							["<2-LeftMouse>"] = "confirm",
							["<CR>"] = "confirm",
							["<Down>"] = "list_down",
							["<Esc>"] = "cancel",
							["<S-CR>"] = { { "pick_win", "jump" } },
							["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
							["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
							["<Up>"] = "list_up",
							["<a-d>"] = "inspect",
							["<a-f>"] = "toggle_follow",
							["<a-h>"] = "toggle_hidden",
							["<a-i>"] = "toggle_ignored",
							["<a-m>"] = "toggle_maximize",
							["<a-p>"] = "toggle_preview",
							["<a-w>"] = "cycle_win",
							["<c-a>"] = "select_all",
							["<c-b>"] = "preview_scroll_up",
							["<c-d>"] = "list_scroll_down",
							["<c-f>"] = "preview_scroll_down",
							["<c-j>"] = "list_down",
							["<c-k>"] = "list_up",
							["<c-n>"] = "list_down",
							["<c-p>"] = "list_up",
							["<c-q>"] = "qflist",
							["<c-g>"] = "print_path",
							["<c-s>"] = "edit_split",
							["<c-t>"] = "tab",
							["<c-u>"] = "list_scroll_up",
							["<c-v>"] = "edit_vsplit",
							["<c-w>H"] = "layout_left",
							["<c-w>J"] = "layout_bottom",
							["<c-w>K"] = "layout_top",
							["<c-w>L"] = "layout_right",
							["?"] = "toggle_help_list",
							["G"] = "list_bottom",
							["gg"] = "list_top",
							["i"] = "focus_input",
							["j"] = "list_down",
							["k"] = "list_up",
							["q"] = "cancel",
							["zb"] = "list_scroll_bottom",
							["zt"] = "list_scroll_top",
							["zz"] = "list_scroll_center",
						},
						wo = {
							conceallevel = 2,
							concealcursor = "nvc",
						},
					},
					-- preview window
					preview = {
						keys = {
							["<Esc>"] = "cancel",
							["q"] = "cancel",
							["i"] = "focus_input",
							["<a-w>"] = "cycle_win",
						},
					},
				},
				---@class snacks.picker.icons
				icons = {
					files = {
						enabled = true, -- show file icons
						dir = "󰉋 ",
						dir_open = "󰝰 ",
						file = "󰈔 ",
					},
					keymaps = {
						nowait = "󰓅 ",
					},
					tree = {
						vertical = "│ ",
						middle = "├╴",
						last = "└╴",
					},
					undo = {
						saved = " ",
					},
					ui = {
						live = "󰐰 ",
						hidden = "h",
						ignored = "i",
						follow = "f",
						selected = "● ",
						unselected = "○ ",
						-- selected = " ",
					},
					git = {
						enabled = true, -- show git icons
						commit = "󰜘 ", -- used by git log
						staged = "●", -- staged changes. always overrides the type icons
						added = "",
						deleted = "",
						ignored = " ",
						modified = "○",
						renamed = "",
						unmerged = " ",
						untracked = "?",
					},
					diagnostics = {
						Error = " ",
						Warn = " ",
						Hint = " ",
						Info = " ",
					},
					lsp = {
						unavailable = "",
						enabled = " ",
						disabled = " ",
						attached = "󰖩 ",
					},
					kinds = {
						Array = " ",
						Boolean = "󰨙 ",
						Class = " ",
						Color = " ",
						Control = " ",
						Collapsed = " ",
						Constant = "󰏿 ",
						Constructor = " ",
						Copilot = " ",
						Enum = " ",
						EnumMember = " ",
						Event = " ",
						Field = " ",
						File = " ",
						Folder = " ",
						Function = "󰊕 ",
						Interface = " ",
						Key = " ",
						Keyword = " ",
						Method = "󰊕 ",
						Module = " ",
						Namespace = "󰦮 ",
						Null = " ",
						Number = "󰎠 ",
						Object = " ",
						Operator = " ",
						Package = " ",
						Property = " ",
						Reference = " ",
						Snippet = "󱄽 ",
						String = " ",
						Struct = "󰆼 ",
						Text = " ",
						TypeParameter = " ",
						Unit = " ",
						Unknown = " ",
						Value = " ",
						Variable = "󰀫 ",
					},
				},
			},
		},

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
