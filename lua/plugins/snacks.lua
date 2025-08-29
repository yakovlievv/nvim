return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = false },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = { step = 15, total = 150 },
                easing = "linear",
            },
            filter = function(buf)
                return vim.g.snacks_scroll ~= false
                and vim.b[buf].snacks_scroll ~= false
                and vim.bo[buf].buftype ~= "terminal"
            end,
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
}
