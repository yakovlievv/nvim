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
				"toml",
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
						-- Filetypes where Neovim's built-in indent is better than
						-- nvim-treesitter's (main branch) — leave their indentexpr alone.
						local skip_ts_indent = {
							json = true,
							jsonc = true,
							yaml = true,
							markdown = true,
						}
						local buf = event.buf
						vim.schedule(function()
							if not vim.api.nvim_buf_is_valid(buf) then
								return
							end
							-- Folding is owned by nvim-ufo (see plugins/ufo.lua).
							if not skip_ts_indent[vim.bo[buf].filetype] then
								vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
							end
						end)
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter-textobjects").setup({})

			local moves = {
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
				},
			}

			local function attach(buf)
				local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
				if not lang or not vim.treesitter.query.get(lang, "textobjects") then
					return
				end
				for method, keys in pairs(moves) do
					for key, query in pairs(keys) do
						local dir = key:sub(1, 1) == "[" and "Prev " or "Next "
						local kind = query:gsub("@", ""):gsub("%..*", "")
						kind = kind:sub(1, 1):upper() .. kind:sub(2)
						local pos = key:sub(2, 2):match("%u") and " End" or " Start"
						vim.keymap.set({ "n", "x", "o" }, key, function()
							require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
						end, { buffer = buf, desc = dir .. kind .. pos, silent = true })
					end
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("yako.ts-textobjects", { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) then
					attach(buf)
				end
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		keys = {
			{ "<leader>ut", "<cmd>TSContextToggle<cr>", desc = "Toggle Treesitter Context" },
		},
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
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
