require("catppuccin").setup({
    flavour = "mocha", -- Set the Mocha variant
    transparent_background = true,
    integrations = {
        treesitter = true, -- Enable Treesitter support
        native_lsp = { enabled = true }, -- Make LSP diagnostics match the theme
    },
})

vim.cmd.colorscheme "catppuccin"

