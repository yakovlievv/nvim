return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		local ts = require("nvim-treesitter")
		local utils = require("utils.treesitter")
		local available_parsers = ts.get_available()

		vim.api.nvim_create_user_command("TSUninstallAll", function()
			require("nvim-treesitter").uninstall(require("nvim-treesitter").get_installed(), { summary = true })
		end, { desc = "Uninstall all installed parsers" })

		-- Check treesitter cli
		utils.ensure_treesitter_cli()
		ts.install({
			"bash",
			"zsh",
			"regex",
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
		}, { summary = false })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			group = vim.api.nvim_create_augroup("my.treesitter", { clear = true }),
			callback = function(event)
				local lang = vim.treesitter.language.get_lang(event.match)
				if not lang then
					return
				end

				-- Try installing parser for current buffer if missing
				if not vim.treesitter.language.add(lang) then
					local is_available = vim.tbl_contains(available_parsers, lang)
					if is_available then
						ts.install(lang)
						vim.notify("Installing parser. Wait, then restart Neovim.")
					end

					-- Try enabling capabilities
				else
					if not pcall(vim.treesitter.start, event.buf, lang) then
						vim.notify("Treesitter failed for " .. lang, vim.log.levels.WARN)
						return
					end
					vim.schedule(function()
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end)
				end
			end,
		})
	end,
}
