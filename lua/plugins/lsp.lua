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
            opts = {
                keymap = { preset = "default" },
                appearance = { nerd_font_variant = "mono" },
                completion = { documentation = { auto_show = false } },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
            },
            opts_extend = { "sources.default" },
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
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end

        require("mason-lspconfig").setup {
            handlers = {
                -- default handler for all servers
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                    }
                end,

            },
        }
    end,
}
