return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {},
	config = function()
		local hooks = require("ibl.hooks")

		-- Define Catppuccin-inspired highlight groups
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Catppuccin Mocha colors
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#313244" }) -- surface0
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#89b4fa" }) -- blue
		end)

		require("ibl").setup({
			indent = {
				char = "│",
				highlight = "IblIndent",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				show_exact_scope = true,
				highlight = "IblScope",
			},
		})
	end,
}
