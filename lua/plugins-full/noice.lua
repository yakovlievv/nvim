return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.opt.cmdheight = 0
	end,
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				hover = {
					opts = {
						-- winhighlight = "Normal:MyDoc,FloatBorder:MyDocBorder",
						-- border = "rounded",
						-- offset_y = 1,
					},
				},
				signature = {
					opts = {
						-- winhighlight = "Normal:MySignature,FloatBorder:MySignatureBorder",
						-- border = "rounded",
						-- offset_y = 1,
					},
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}
