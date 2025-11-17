return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- Use the main branch (note: master is deprecated). :contentReference[oaicite:2]{index=2}
		build = ":TSUpdate", -- Update parsers after install/update
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"python",
					"javascript",
					"typescript",
					"go",
					"rust",
					"bash",
					"c",
					"diff",
					"html",
					"json",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"vimdoc",
					"yaml",
				},
				auto_install = true, -- automatically install missing parsers when entering buffer
				sync_install = false, -- don't block Neovim startup
				highlight = {
					enable = true, -- enable treesitter based highlighting
					additional_vim_regex_highlighting = false, -- disable redundant vim regex highlighting
				},
				indent = {
					enable = true, -- enable treesitter based indentation
				},
				folding = {
					enable = true,
					-- Use Neovim's foldexpr for treesitter if desired:
					-- Only if you set vim.wo.foldmethod = 'expr' and
					-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				},
				-- Optionally setup textobjects, based on nvim-treesitter-textobjects plugin
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
					},
				},
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
	},
	-- (You may also need to include the textobjects plugin)
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = "nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false,
					},
				},
			})
		end,
	},
}
