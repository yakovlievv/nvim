return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		require("nvim-treesitter").setup()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function()
				-- Enable highlighting
				pcall(vim.treesitter.start)
				-- Enable folds
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				-- Enable indent
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
