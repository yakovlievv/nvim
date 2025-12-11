return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },

	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,

	config = function()
		local Snacks = require("snacks")

		-- Helper function to format with highlights
		local function format_hl(text, hl_group)
			if not hl_group or hl_group == "" then
				return text
			end
			return "%#" .. hl_group .. "#" .. text .. "%*"
		end
		vim.opt.showmode = false
		-- Pretty path component
		local function pretty_path()
			local path = vim.fn.expand("%:p")
			if path == "" then
				return ""
			end

			-- Get relative path from cwd
			local cwd = vim.fn.getcwd()
			if path:find(cwd, 1, true) == 1 then
				path = path:sub(#cwd + 2)
			end

			-- Split path into parts
			local sep = package.config:sub(1, 1)
			local parts = vim.split(path, "[\\/]")

			-- Shorten if too long (keep first, last 2, and ellipsis)
			if #parts > 3 then
				parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
			end

			-- Build the path with separate highlights
			if #parts == 1 then
				-- Only filename, no directory
				local hl = vim.bo.modified and "Constant" or "Bold"
				return format_hl(parts[1], hl)
			else
				-- Separate directory and filename
				local filename = table.remove(parts)
				local dirpath = table.concat(parts, sep) .. sep

				-- Apply different highlights
				local dir_hl = "Comment" -- Dimmed for directory
				local file_hl = vim.bo.modified and "Constant" or "Bold"

				return format_hl(dirpath, dir_hl) .. format_hl(filename, file_hl)
			end
		end
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
					{ pretty_path },
				},

				lualine_x = {
					Snacks.profiler.status(),

					-- DAP status
					{
						function()
							return "  " .. require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
						color = function()
							return { fg = Snacks.util.color("Debug") }
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
							return { fg = Snacks.util.color("Statement") }
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
							return { fg = Snacks.util.color("Constant") }
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
							added = ICONS.git_diff.added,
							modified = ICONS.git_diff.modified,
							removed = ICONS.git_diff.removed,
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
		})
	end,

	opts = function(_, opts)
		-- Helper function to get relative path

		-- Add to lualine config
		opts.sections = opts.sections or {}
		opts.sections.lualine_c = {}
	end,
}
