return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			"lua_ls",
			"ts_ls",
			"emmet_ls",
			"html",
			"cssls",
			"pyright",
			"eslint",
		},
	},
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = { border = "rounded" },
			},
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				local capabilities = require("blink-cmp").get_lsp_capabilities()
				vim.lsp.config("*", { capabilities = capabilities })
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
		{
			"antosha417/nvim-lsp-file-operations",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-neo-tree/neo-tree.nvim",
			},
			config = function()
				require("lsp-file-operations").setup()
			end,
		},
	},
}
