return {
	{
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
				"latex",
				"gitignore",
				"scss",
				"svelte",
				"typst",
				"vue",
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
							vim.wo.foldtext = "v:lua.fold_text()"
							vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						end)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
