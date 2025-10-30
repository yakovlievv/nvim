return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("blink-cmp").get_lsp_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })
			-- Show diagnostic for the current line in a floating window
			vim.keymap.set("n", "<leader>d", function()
				vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
			end, { desc = "Show line diagnostics" })
		end,
	},
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
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
			ui = { border = "rounded" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		opts = {
			ensure_installed = {
				-- webdev
				"ts_ls",
				"eslint",
				"emmet_ls",
				"html",
				"cssls",
				"jsonls",
				--markdown
				"marksman",
				-- Python
				"pyright",
				-- Lua
				"lua_ls",
				-- C / C++
				"clangd",
			},
		},
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "mason-org/mason.nvim" },
			{ "folke/lazydev.nvim" },
			{ "antosha417/nvim-lsp-file-operations" },
		},
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
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
