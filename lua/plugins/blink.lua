return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	opts_extend = { "sources.default" },
	version = "1.*",
	build = "source ~/.local/share/cargo/env && cargo build --release",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		"folke/lazydev.nvim",
	},

	config = function()
		require("blink.cmp").setup({
			-- cmdline = {
			-- 	enabled = true,
			-- 	keymap = { preset = "inherit" },
			-- 	completion = {
			-- 		menu = { auto_show = true },
			-- 		ghost_text = { enabled = false },
			-- 	},
			-- },

			keymap = {
				preset = "none",
				["<C-d>"] = { "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<C-y>"] = { "select_and_accept", "show" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-j>"] = { "select_next", "fallback_to_mappings" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				menu = {
					-- border = "rounded",
					-- scrollbar = false,
				},
				ghost_text = {
					enabled = true,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 10,
					-- window = { border = "rounded" },
				},
			},

			-- signature = { window = { border = "rounded" } },

			snippets = {
				preset = "luasnip",
			},

			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		})

		-- BlinkCmp highlights for solid background
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#181825", fg = "#cdd6f4" })
		-- vim.api.nvim_set_hl(0, "BlinkCmpDocumentation", { bg = "#181825", fg = "#cdd6f4" })
		-- vim.api.nvim_set_hl(0, "BlinkCmpSignature", { bg = "#181825", fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#181825" }) -- pick your color
		vim.api.nvim_set_hl(0, "NoiceHover", { bg = "#181825", fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "NoicePopup", { bg = "#181825", fg = "#cdd6f4" })
		-- vim.api.nvim_set_hl(0, "MyDoc", { bg = "#181825", fg = "#cdd6f4" })
		-- vim.api.nvim_set_hl(0, "MyDocBorder", { bg = "#181825", fg = "#cdd6f4" })
	end,
}
