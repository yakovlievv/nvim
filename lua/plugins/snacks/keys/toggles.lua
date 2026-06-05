return {
    --stylua: ignore start
    { "<leader>un", function() Snacks.notifier.hide() end,                                                                                desc = "Dismiss All Notifications" },
    { "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }):toggle() end,                                         desc = "Toggle Spelling" },
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end,                                                                  desc = "Toggle Diagnostics" },
    { "<leader>ul", function() Snacks.toggle.line_number():toggle() end,                                                                  desc = "Toggle Line Number" },
    { "<leader>uT", function() Snacks.toggle.treesitter():toggle() end,                                                                   desc = "Toggle Treesitter" },
    { "<leader>ub", function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end, desc = "Toggle Background" },
    { "<leader>uS", function() Snacks.toggle.scroll():toggle() end,                                                                       desc = "Toggle Scroll" },
    {
        "<leader>uc",
        function()
            Snacks.toggle.option("conceallevel", {
                off = 0,
                on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
                name = "Conceal Level",
            }):toggle()
        end,
        desc = "Toggle Conceal Level",
    },
    { "<leader>uA", function()
        Snacks.toggle.option("showtabline", {
            off = 0,
            on = vim.o.showtabline > 0 and vim.o.showtabline or 2,
            name = "Tabline",
        }):toggle()
    end,
        desc = "Toggle Tabline",
    },
    { "<leader>ui", function()
        Snacks.toggle({
            name = "Image",
            get = function() return Snacks.config.image.enabled end,
            set = function(v) Snacks.config.image.enabled = v end,
        }):toggle()
    end, desc = "Toggle Image" },
    { "<leader>uI", function() Snacks.toggle.inlay_hints():toggle() end,          desc = "Toggle Inlay Hints" },
    { "<leader>Dpp", function() Snacks.toggle.profiler():toggle() end,            desc = "Toggle Profiler" },
    { "<leader>Dph", function() Snacks.toggle.profiler_highlights():toggle() end, desc = "Toggle Profiler Highlights" },
    --stylua: ignore end
}
