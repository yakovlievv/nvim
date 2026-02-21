return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		---@type false | "classic" | "modern" | "helix"
		preset = "helix",
		-- Delay before showing the popup. Can be a number or a function that returns a number.
		---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
		delay = function(ctx)
			return ctx.plugin and 0 or 500
		end,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>b", group = "buffers" },
			{ "<leader>c", group = "code" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "hunks" },
			{ "<leader>s", group = "search" },
			{ "<leader>y", group = "yazi" },
			{ "<leader>t", group = "treesitter" },
			{ "<leader>v", group = "void (no yank)" },
			{ "<leader>j", group = "split/join" },
			{ "<leader>u", group = "ui toggles" },
			{ "<leader>d", group = "debug" },
			{ "]", group = "next" },
			{ "[", group = "prev" },
			{ "g", group = "goto" },
			{ "ga", group = "calls" },
		})
	end,
}
