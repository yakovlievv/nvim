return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		local ts = require("nvim-treesitter")
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
		local available_parsers = ts.get_available()

		-- Installation proccess of a parser
		local function parser_sync(parser)
			local is_installed, _ = vim.treesitter.language.add(parser)
			if not is_installed then
				local is_available = vim.tbl_contains(available_parsers, parser)
				if is_available then
					vim.notify("TS installing: " .. parser, vim.log.levels.INFO)
					ts.install({ parser }):wait(30 * 1000)
					vim.notify("Installed " .. parser, vim.log.levels.INFO)
					return true
				end
			end
			return false
		end

		-- Sync ensure_installed
		-- for _, parser in ipairs(ensure_installed) do
		-- 	vim.schedule(function()
		-- 		parser_sync(parser)
		-- 	end)
		-- end

		local augroup = vim.api.nvim_create_augroup("my.treesitter", { clear = true })
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "*",
		-- 	group = augroup,
		-- 	callback = function(event)
		-- 		local lang = vim.treesitter.language.get_lang(event.match)
		-- 		local is_installed = parser_sync(lang)
		-- 		if is_installed then
		-- 			local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
		--
		-- 			if not ok then
		-- 				vim.notify("Treesitter fucked up!" .. lang, vim.log.levels.INFO)
		-- 				return
		-- 			end
		--
		-- 			vim.wo.foldmethod = "expr"
		-- 			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- 			vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- 		end
		-- 	end,
		-- })
	end,
}
