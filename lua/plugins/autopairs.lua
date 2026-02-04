return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true, -- use treesitter
			enable_check_bracket_line = false,
		})

		-- Add spaces inside pairs when you hit space
		local Rule = require("nvim-autopairs.rule")
		local npairs = require("nvim-autopairs")

		npairs.add_rules({
			Rule(" ", " "):with_pair(function(opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({ "()", "[]", "{}" }, pair)
			end),
		})
	end,
}
