return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.icons", "catppuccin" },

	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,

	config = function()
		local snacks = require("snacks")
		local utils = require("utils.lualine")
		local icons = require("utils.icons")

		vim.opt.laststatus = 3

		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = { "dashboard", "snacks_dashboard" } },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },

				lualine_c = {
					"diagnostics",
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ utils.pretty_path },
				},

				lualine_x = {
					snacks.profiler.status(),

					-- DAP status
					{
						function()
							return "  " .. require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
						color = function()
							return { fg = snacks.util.color("Debug") }
						end,
					},

					-- Noice command status (first, like LazyVim)
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
						color = function()
							return { fg = snacks.util.color("Statement") }
						end,
					},

					-- Noice mode (macro recording, etc)
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = function()
							return { fg = snacks.util.color("Constant") }
						end,
					},

					-- Lazy updates
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return { fg = "#fab387" }
						end,
					},

					-- Git diff
					{
						"diff",
						symbols = {
							added = icons.git_diff.added,
							modified = icons.git_diff.modified,
							removed = icons.git_diff.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},

				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},

				lualine_z = {
					{
						"lsp_status",
						icon = "",
						symbols = {
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							done = "✓",
							separator = "  ",
						},
						ignore_lsp = {},
						show_name = true,
					},
				},
			},
			extensions = { "neo-tree", "lazy", "fzf", "mason", "quickfix" },
		})
	end,

	opts = function(_, opts)
		-- Add to lualine config
		opts.sections = opts.sections or {}
		opts.sections.lualine_c = {}
	end,
}
