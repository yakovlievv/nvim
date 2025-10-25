return {
	"mason-org/mason-lspconfig.nvim",
	event = "BufReadPre",
	opts = {
		ensure_installed = {
			"html",
			"emmet_ls",
			"cssls",
			"lua_ls",
			"ts_ls",
			"jsonls",
			"eslint",
			"pyright",
		},
		-- handlers = {
		--     function(server_name)
		--         require("lspconfig")[server_name].setup({
		--             capabilities = capabilities,
		--             on_attach = on_attach,
		--         })
		--     end,
		-- },
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
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
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
		-- local capabilities = require("blink.cmp").get_lsp_capabilities()

		local set = vim.keymap.set
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definition"
				set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition

				opts.desc = "Show LSP implementations"
				set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts) -- jump to previous diagnostic in buffer
				--
				opts.desc = "Go to next diagnostic"
				set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- vim.lsp.inlay_hint.enable(true)

		local severity = vim.diagnostic.severity

		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = " ",
					[severity.WARN] = " ",
					[severity.HINT] = "󰠠 ",
					[severity.INFO] = " ",
				},
			},
		})
	end,
}
