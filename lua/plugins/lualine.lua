return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status") -- lazy provides this

		local lazy_updates = {
			function()
				if lazy_status.has_updates() then
					return "󰏗 " .. lazy_status.updates()
				end
				return ""
			end,
			cond = lazy_status.has_updates, -- only show when updates exist
			color = { fg = "#ff9e64" }, -- optional color
		}

		require("lualine").setup({
			sections = {
				lualine_x = { lazy_updates, "encoding", "filetype" },
			},
		})
	end,
}
