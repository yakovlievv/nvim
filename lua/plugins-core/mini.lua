return {
    {
        "nvim-mini/mini.surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            local surround = require('mini.surround')
            surround.setup({
                mappings = {
                    add = '<A-s>a',       -- Add surrounding in Normal and Visual modes
                    delete = '<A-s>d',    -- Delete surrounding
                    find = '<A-s>f',      -- Find surrounding (to the right)
                    find_left = '<A-s>F', -- Find surrounding (to the left)
                    highlight = '<A-s>h', -- Highlight surrounding
                    replace = '<A-s>r',   -- Replace surrounding


                    suffix_last = 'h', -- Suffix to search with "prev" method
                    suffix_next = 'l', -- Suffix to search with "next" method
                },
            })
            vim.keymap.del('n', 'sn')
        end,
    },
    {
        "nvim-mini/mini.ai",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("mini.ai").setup()
        end,
    }
}
