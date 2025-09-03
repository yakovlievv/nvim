return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            opts = {
                ui = { border = "rounded" },
            },
        },
        {
            "williamboman/mason-lspconfig.nvim",
            opts = {},
        },
        {
            "jose-elias-alvarez/null-ls.nvim",
        },
        -- Optional: fidget to show LSP progress
        {
            "j-hui/fidget.nvim",
            opts = {},
        },
        -- Blink completion
        {
        },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local null_ls = require("null-ls")
        local blink_cmp = require("blink.cmp")

        -- Extend capabilities for blink.cmp
        local capabilities = blink_cmp.extend_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Keymaps for LSP
        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end

        -- Mason setup
        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = { "lua_ls", "pyright", "tsserver" },
        })

        -- Setup each installed LSP server
        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        },
                    },
                })
            end,
        })

        -- Null-ls setup
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.completion.spell,
            },
            on_attach = on_attach,
        })

        -- Autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        -- Diagnostic config
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            severity_sort = true,
        })
    end,
}
