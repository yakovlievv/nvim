return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"python",
				"javascript",
				"go",
				"rust",
				"bash",
				"c",
				"diff",
				"html",
				"json",
				"jsonc",
				"markdown_inline",
				"markdown",
				"typescript",
				"markdown",
				"python",
				"query",
				"regex",
				"tsx",
				"vimdoc",
				"yaml",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			folding = { enable = true },
			autotag = { enable = false },
		})

		-- Optional: Set up folding by default in all buffers
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end,
		})
	end,
}
