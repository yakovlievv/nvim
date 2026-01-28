return {
	"stevearc/quicker.nvim",
	event = "BufReadPost",
	keys = {
        -- stylua: ignore
        { "<leader>q", function() require("quicker").toggle() end, { desc = "Toggle quickfix", }},

        -- stylua: ignore
        { "<leader>L", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist", }},
	},
	config = function()
		require("quicker").setup({
			opts = {},
		})
	end,
}
