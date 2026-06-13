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
				require("luasnip").setup({
					-- visual-select text, press this key to stash it into
					-- TM_SELECTED_TEXT, then type the snippet trigger
					store_selection_keys = "<Tab>",
				})
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_lua").lazy_load({
					paths = { vim.fn.stdpath("config") .. "/luasnippets" },
				})
			end,
		},
		"folke/lazydev.nvim",
		{
			"Kaiser-Yang/blink-cmp-dictionary",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
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
				-- one key to hide everything (menu + docs + signature); shows it back when nothing is open
				["<C-e>"] = {
					function(cmp)
						if cmp.is_visible() or cmp.is_signature_visible() then
							cmp.hide()
							cmp.hide_signature()
							return true
						end
						cmp.show()
						cmp.show_signature()
						return true
					end,
				},
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
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "dictionary" },
				providers = {
					lazydev = {
						name = "[Dev]",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					lsp = { name = "[LSP]" },
					path = { name = "[Path]" },
					snippets = { name = "[Snip]" },
					buffer = { name = "[Buf]" },
					dictionary = {
						name = "[Dict]",
						module = "blink-cmp-dictionary",
						min_keyword_length = 3,
						-- only pull dictionary words in prose-y filetypes
						enabled = function()
							return vim.tbl_contains(
								{ "markdown", "text", "gitcommit", "tex", "" },
								vim.bo.filetype
							)
						end,
						opts = {
							dictionary_files = { "/usr/share/dict/words" },
						},
					},
				},
			},
		})
	end,
}
