return {
	"nvimtools/none-ls.nvim",
	event = "BufReadPre",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black,
			},
		})

		-- In your lua config, e.g., `after/plugin/format.lua`
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			pattern = "*", -- all filetypes, or you can restrict to e.g., "*.py"
			callback = function()
				local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
				for _, client in ipairs(clients) do
					if client.supports_method("textDocument/formatting") then
						vim.lsp.buf.format({
							bufnr = 0,
							filter = function(c)
								return c.name == "null-ls"
							end, -- only use null-ls
						})
					end
				end
			end,
		})
	end,
}
