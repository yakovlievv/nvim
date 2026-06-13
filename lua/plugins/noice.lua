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
			routes = {
				{
					view = "notify",
					filter = { event = "msg_show", kind = { "echo", "echomsg" } },
				},
				{
					filter = { event = "notify", find = "No information available" },
					opts = { skip = true },
				},
				{
					filter = {
						event = "lsp",
						kind = "progress",
						cond = function(message)
							local client = vim.tbl_get(message.opts, "progress", "client")
							return client == "basedpyright" or client == "ruff"
						end,
					},
					opts = { skip = true },
				},
			},
			messages = {
				enabled = true,
				view = "mini", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
			},
			lsp = {
				signature = { enabled = false },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}
