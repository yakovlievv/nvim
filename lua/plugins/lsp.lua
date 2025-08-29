return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    border = "rounded",
                }
            }
        },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {}
        },
    },
    config = function ()
        require('mason').setup()
        require("mason-lspconfig").setup({

        })
    end
}
