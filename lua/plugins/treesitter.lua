return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	branch = "master",
	build = ":TSUpdate",
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- avoid double highlighting
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			autotag = {
				enable = false, -- enable only if you install nvim-ts-autotag
			},
			auto_install = true,
			sync_install = false,
		})
	end,
}
