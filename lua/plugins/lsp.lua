return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		{
			"mason-org/mason.nvim",
			event = "BufReadPre",
			opts = {
				ui = { border = "rounded" },
			},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			event = "BufReadPre",
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			event = "BufReadPre",
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		require("mason").setup()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.jump({ count = 1, float = true }))
			vim.keymap.set("n", "[d", vim.diagnostic.jump({ count = -1, float = true }))
			vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })
		end

		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"emmet_ls",
				"cssls",
				"ts_ls",
				"jsonls",
				"eslint",
				"pyright",
			},
			handlers = {
				-- default handler for all servers
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			},
		})
	end,
}
