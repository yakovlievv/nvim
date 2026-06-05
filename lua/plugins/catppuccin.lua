return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			compile = true,
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			float = {
				transparent = true, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.50, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = function(colors)
				return {
					-- Squiggly (undercurl) diagnostics, like LazyVim/VSCode
					DiagnosticUnderlineError = { undercurl = true, sp = colors.red },
					DiagnosticUnderlineWarn = { undercurl = true, sp = colors.yellow },
					DiagnosticUnderlineInfo = { undercurl = true, sp = colors.sky },
					DiagnosticUnderlineHint = { undercurl = true, sp = colors.teal },
					DiagnosticUnderlineOk = { undercurl = true, sp = colors.green },
					-- Mason
					MasonNormal = { bg = colors.mantle },
					MasonBorder = { bg = colors.mantle, fg = colors.mantle },
					-- Blink (completion menu, docs, signature)
					BlinkCmpMenu = { bg = colors.mantle },
					BlinkCmpMenuBorder = { bg = colors.mantle, fg = colors.mantle },
					BlinkCmpDoc = { bg = colors.mantle },
					BlinkCmpDocBorder = { bg = colors.mantle, fg = colors.mantle },
					BlinkCmpSignatureHelp = { bg = colors.mantle },
					BlinkCmpSignatureHelpBorder = { bg = colors.mantle, fg = colors.mantle },
					-- Noice (LSP hover, command popup)
					NoiceHover = { bg = colors.mantle, fg = colors.text },
					NoicePopup = { bg = colors.mantle, fg = colors.text },
					-- CursorLine
					CursorLine = { bg = colors.mantle },
					-- Treesitter Context
					TreesitterContext = { bg = "NONE", fg = "NONE" },
					TreesitterContextBottom = { fg = "NONE", bg = "NONE" },
					LazyNormal = { bg = colors.base },
					SnacksPickerListVscode = { bg = colors.base },
					-- Bufferline neo-tree offset header
					BufferlineOffsetDim = { fg = colors.surface0 },
				}
			end,
			default_integrations = true,
			auto_integrations = true,
			integrations = {
				nvim_web_devicons = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,

	specs = {
		{
			"akinsho/bufferline.nvim",
			optional = true,
			opts = function(_, opts)
				if (vim.g.colors_name or ""):find("catppuccin") then
					opts.highlights = require("catppuccin.special.bufferline").get_theme()
				end
			end,
		},
	},
}
