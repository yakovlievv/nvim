return {
	"mason-org/mason-lspconfig.nvim",
	event = "BufReadPre",
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
			cmd = "Mason",
			opts = {
				ui = { border = "rounded" },
			},
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				local capabilities = require("blink-cmp").get_lsp_capabilities()
				-- local signature = require("lsp_signature")

				vim.lsp.config("*", { capabilities = capabilities })

				-- attach signature only when LSP is active
				-- vim.api.nvim_create_autocmd("LspAttach", {
				-- 	callback = function(args)
				-- 		local bufnr = args.buf
				-- 		signature.on_attach(nil, bufnr)
				-- 	end,
				-- })
			end,
		},
		-- {
		-- 	"ray-x/lsp_signature.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		bind = true, -- Required
		-- 		hint_enable = true, -- show inline hints (virtual text)
		-- 		hint_prefix = "󰘧 ", -- symbol before hint
		-- 		floating_window = true, -- show floating window with signature
		-- 		handler_opts = {
		-- 			border = "rounded",
		-- 		},
		-- 		transparency = 100, -- slightly transparent background
		-- 		max_height = 12,
		-- 		max_width = 80,
		-- 		toggle_key = "<M-x>", -- press Alt+x to toggle signature window
		-- 	},
		-- 	config = function(_, opts)
		-- 		require("lsp_signature").setup(opts)
		-- 	end,
		-- },
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
	},
}
