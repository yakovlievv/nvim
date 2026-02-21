return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.lsp.config("*", { capabilities = require("blink-cmp").get_lsp_capabilities() })
			vim.lsp.config("cssls", {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				root_markers = {
					"postcss.config.js",
					"postcss.config.mjs",
					"postcss.config.cjs",
					"postcss.config.ts",
					"package.json",
					".git",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})

		end,
	},

	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = { border = "rounded" },
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		event = "BufReadPre",
		opts = {
			ensure_installed = {
				"vtsls", -- TypeScript/JavaScript
				"tailwindcss",
				"eslint", -- ESLint
				-- "emmet_ls", -- Emmet
				"html", -- HTML
				"cssls", -- CSS
				"jsonls", -- JSON
				"marksman", -- Markdown
				"pyright", -- Python
				"lua_ls", -- Lua
				"clangd", -- C/C++
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"prettierd", -- JS/TS/HTML/CSS/JSON/Markdown etc.
					"stylua", -- Lua
					"black", -- Python
					"isort", -- Python import sorter
					"clang-format", -- C/C++
					"shfmt", -- Shell scripts
					-- Linters
					"ruff", -- Python linter
					"shellcheck", -- Shell scripts
				},
				auto_update = false,
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
