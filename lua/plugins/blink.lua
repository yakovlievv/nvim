return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	opts_extend = { "sources.default" },
	version = "1.*",
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
	},

	config = function()
		require("blink.cmp").setup({
			cmdline = {
				enabled = true,
				keymap = { preset = "inherit" },
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = true },
				},
			},

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
					border = "single",
					scrollbar = false,
				},
				ghost_text = {
					enabled = true,
				},
				documentation = { auto_show = true, auto_show_delay_ms = 10, window = { border = "single" } },
			},

			signature = { window = { border = "single" } },

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
	end,
}
