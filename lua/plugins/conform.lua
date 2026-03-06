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
					python = { "ruff_organize_imports", "ruff_format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
				},
				format_on_save = {
					lsp_format = "fallback",
					async = false,
					timeout_ms = 1500,
				},
			})
		end,
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({
						lsp_format = "fallback",
						async = true,
						timeout_ms = 1000,
					})
				end,
				desc = "format",
			},
		},
	},
}
