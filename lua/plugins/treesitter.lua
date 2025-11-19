return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	opts = {
		ensure_installed = {
			"lua",
			"jsx",
			"tsx",
			"javascript",
		},
	},
	config = function()
		local ts = require("nvim-treesitter")
		local augroup = vim.api.nvim_create_augroup("my.treesitter", { clear = true })

		ts.setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			group = augroup,
			callback = function(event)
				local filetype = event.match
				local lang = vim.treesitter.language.get_lang(filetype)
				local is_installed, error = vim.treesitter.language.add(lang)

				if not is_installed then
					vim.notify("Installing treesitter parser for " .. lang, vim.log.levels.INFO)
				end
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
