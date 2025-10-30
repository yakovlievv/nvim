return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {}, -- empty or a small curated list
			sync_install = false,
			auto_install = true, -- install missing parsers when entering buffer
			highlight = { enable = true },
			autotag = { enable = true }, -- if you keep nvim-ts-autotag
			indent = { enable = true },
			incremental_selection = { enable = true },
		})
	end,
}
