return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		local ts = require("nvim-treesitter")
		local augroup = vim.api.nvim_create_augroup("my.treesitter", { clear = true })
		local ensure_installed = {
			"bash",
			"c",
			"cpp",
			"lua",
			"python",
			"javascript",
			"typescript",
			"jsx",
			"tsx",
			"html",
			"css",
			"json",
			"markdown",
			"yaml",
			"gitcommit",
			"vim",
		}

		ts.setup()

		for _, parser in ipairs(ensure_installed) do
			local is_installed, _ = vim.treesitter.language.add(parser)
			if not is_installed then
				local available_langs = ts.get_available()
				local is_available = vim.tbl_contains(available_langs, parser)
				if is_available then
					vim.notify("Installing treesitter parser for: " .. parser, vim.log.levels.INFO)
					ts.install({ parser }):wait(30 * 1000)
				else
					vim.notify("The parser doesn't exist: " .. parser, vim.log.levels.INFO)
				end
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			group = augroup,
			callback = function(event)
				local filetype = event.match
				local lang = vim.treesitter.language.get_lang(filetype)
				local is_installed, _ = vim.treesitter.language.add(lang)

				if not is_installed then
					local available_langs = ts.get_available()
					local is_available = vim.tbl_contains(available_langs, lang)

					if is_available then
						vim.notify("Installing treesitter parser for " .. lang, vim.log.levels.INFO)
						ts.install({ lang }):wait(30 * 1000)
					end
				end

				if is_installed then
					local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
					if not ok then
						vim.notify("Treesitter fucked up!" .. lang, vim.log.levels.INFO)
					end
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
