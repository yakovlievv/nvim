return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = { border = "rounded" },
			},
		},
		{ "mason-org/mason-lspconfig.nvim" },
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			opts_extend = { "sources.default" },
			config = function()
				require("blink-cmp").setup({
					keymap = { preset = "default" },
					appearance = { nerd_font_variant = "mono" },
					completion = {
						ghost_text = { enabled = true },
						documentation = { auto_show = true, auto_show_delay_ms = 0 },
					},
					sources = {
						default = { "lazydev", "lsp", "path", "snippets", "buffer" },
						providers = {
							lazydev = {
								name = "LazyDev",
								module = "lazydev.integrations.blink",
								-- make lazydev completions top priority (see `:h blink.cmp`)
								score_offset = 100,
							},
						},
					},
				})
			end,
		},
		{
			"nvimtools/none-ls.nvim",
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
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
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
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

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.black,
			},
		})

		-- In your lua config, e.g., `after/plugin/format.lua`
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			pattern = "*", -- all filetypes, or you can restrict to e.g., "*.py"
			callback = function()
				local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
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
