return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	opts_extend = { "sources.default" },
	version = "1.*",
	build = "source ~/.local/share/cargo/env && cargo build --release",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "v2.*",
			build = "make install_jsregexp",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").lazy_load({
					paths = { vim.fn.stdpath("config") .. "/luasnippets" },
				})
			end,
		},
		"folke/lazydev.nvim",
		{
			"supermaven-inc/supermaven-nvim",
			config = function()
				require("supermaven-nvim").setup({
					disable_keymaps = true,
				})
				-- Disable inline ghost text; blink-cmp-supermaven handles completions
				require("supermaven-nvim.completion_preview").disable_inline_completion = true
			end,
		},
		"huijiro/blink-cmp-supermaven",
	},

	config = function()
		require("blink.cmp").setup({
			cmdline = {
				enabled = true,
				keymap = { preset = "inherit" },
				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = false },
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
					-- border = "rounded",
					-- scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
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

			signature = { enabled = true, window = { border = "none" } },

			snippets = {
				preset = "luasnip",
			},

			sources = {
				default = { "lazydev", "lsp", "supermaven", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "[Dev]",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					supermaven = {
						name = "[AI]",
						module = "blink-cmp-supermaven",
						async = true,
						score_offset = 90,
					},
					lsp = { name = "[LSP]" },
					path = { name = "[Path]" },
					snippets = { name = "[Snip]" },
					buffer = { name = "[Buf]" },
				},
			},
		})
	end,
}
