return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {}, -- empty or a small curated list
			sync_install = false,
			auto_install = true, -- install missing parsers when entering buffer
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
