return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			local blink = require("blink-cmp")
			local capabilities = blink.get_lsp_capabilities()
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
			ui = { border = "none" },
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
			-- { "antosha417/nvim-lsp-file-operations" },
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
	-- {
	-- 	"antosha417/nvim-lsp-file-operations",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-neo-tree/neo-tree.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("lsp-file-operations").setup()
	-- 	end,
	-- },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		event = "BufReadPre",
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

				auto_update = true,

				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
		end,
	},
}
