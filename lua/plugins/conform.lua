return {
	{
		"stevearc/conform.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		event = "BufWritePre", -- Trigger lazy load before writing buffer
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
					svelte = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					markdown = { "prettierd" },
					graphql = { "prettierd" },
					liquid = { "prettierd" },
					lua = { "stylua" },
					python = { "isort", "black" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 3000,
				},
			})
		end,
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({
						lsp_fallback = true,
						async = true,
						timeout_ms = 1000,
					})
				end,
				desc = "format",
			},
		},
	},
}
