return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- eslint already runs via LSP — no need to duplicate
			python = { "ruff" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				-- only lint if the buffer has a file on disk
				if vim.bo.buftype == "" then
					lint.try_lint()
				end
			end,
		})
	end,
}
