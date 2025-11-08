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
		Snacks = require("snacks")
		vim.opt.laststatus = 3 -- global statusline
		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "dashboard", "snacks_dashboard" } },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = {
					"searchcount",
					Snacks.profiler.status(),
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                        color = function() return { fg = Snacks.util.color("Statement") } end,
                    },
                    -- stylua: ignore
                    {
                        function() return require("noice").api.status.mode.get() end,
                        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                        color = function() return { fg = "#94e2d5" } end,
                    },
                    -- stylua: ignore
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                        color = function() return { fg = Snacks.util.color("Debug") } end,
                    },
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return { fg = "#fab387" }
						end,
					},
				},
				lualine_y = { "progress", "location" },
				lualine_z = { "lsp_status" },
			},
		})
	end,
}
