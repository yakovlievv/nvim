return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
	opts = {},
	config = function()
		require("render-markdown").setup({
			completions = { lsp = { enabled = true } },
		})
	end,
}
