return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "b0o/SchemaStore.nvim", lazy = true, version = false },
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities(),
				require("lsp-file-operations").default_capabilities()
			)
			-- nvim-ufo: advertise folding range support so the lsp fold provider works.
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			vim.lsp.config("*", { capabilities = capabilities })
			vim.lsp.config("cssls", {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
					scss = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				root_markers = {
					"postcss.config.js",
					"postcss.config.mjs",
					"postcss.config.cjs",
					"postcss.config.ts",
					"package.json",
					".git",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								{ "twMerge\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
			})

			vim.lsp.config("eslint", {
				settings = {
					rulesCustomizations = {
						{ rule = "@typescript-eslint/no-unused-vars", severity = "off" },
					},
				},
			})

			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						disableOrganizeImports = true, -- ruff handles imports
						analysis = {
							typeCheckingMode = "standard",
							autoImportCompletions = true,
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "openFilesOnly",
							inlayHints = {
								variableTypes = true,
								callArgumentNames = true,
								functionReturnTypes = true,
								genericTypes = false,
							},
						},
					},
				},
			})

			vim.lsp.config("ruff", {
				on_attach = function(client, _)
					-- let basedpyright own hover
					client.server_capabilities.hoverProvider = false
				end,
			})

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							-- disable built-in store, use SchemaStore.nvim instead
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
						validate = true,
						format = { enable = true },
					},
				},
			})

			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { completeFunctionCalls = true },
						preferences = { importModuleSpecifier = "shortest" },
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
					javascript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { completeFunctionCalls = true },
						preferences = { importModuleSpecifier = "shortest" },
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			})

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
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"vtsls", -- TypeScript/JavaScript
				"tailwindcss",
				"eslint", -- ESLint
				"html", -- HTML
				"cssls", -- CSS
				"jsonls", -- JSON
				"yamlls", -- YAML
				"marksman", -- Markdown
				"basedpyright", -- Python (types, hover, completions)
				"ruff", -- Python (lints, code actions, organize imports)
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"bashls", -- Bash / zsh
				"taplo", -- TOML (pyproject.toml, Cargo.toml, etc.)
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"prettierd", -- JS/TS/HTML/CSS/JSON/Markdown etc.
					"stylua", -- Lua
					"clang-format", -- C/C++
					"shfmt", -- Shell scripts
					-- Linters
					"shellcheck", -- Shell scripts
				},
				auto_update = false,
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
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
}
