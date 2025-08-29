return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"htmldjango",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"printf",
			"python",
			"query",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
	},
}











