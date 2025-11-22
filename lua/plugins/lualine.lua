return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	config = function()
		local snacks = require("snacks")
		vim.opt.laststatus = 3 -- global statusline
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
					{
						"filename",
						padding = { left = 0, right = 1 },
						separator = "",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1, -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 40, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_x = {
					snacks.profiler.status(),

                    -- stylua: ignore
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        color = function() return { fg = snacks.util.color("Debug") } end,
                    },
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.mode.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = function() return { fg = Snacks.util.color("Constant") } end,
                    },
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        color = function() return { fg = snacks.util.color("Statement") } end,

                    },
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return { fg = "#fab387" }
						end,
					},

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
						icon = "", -- f013
						symbols = {
							-- Standard unicode symbols to cycle through for LSP progress:
							spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
							-- Standard unicode symbol for when LSP is done:
							done = "✓",
							-- Delimiter inserted between LSP names:
							separator = "  ",
						},
						-- list of LSP names to ignore (e.g., `null-ls`):
						ignore_lsp = {},
						show_name = true,
					},
				},
			},
		})
	end,
}
