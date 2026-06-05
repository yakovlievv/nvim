return {
    --stylua: ignore start
    -- Top Pickers
    { "<C-f>",      function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
    { "<leader>/",  function() Snacks.picker.grep() end,            desc = "Grep" },
    { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function()
        Snacks.picker.notifications({
            layout = {
                preset = "vertical",
                layout = {
                    backdrop = false,
                    width = 0.7,
                    min_width = 30,
                    height = 0.7,
                    min_height = 30,
                    box = "vertical",
                    border = true,
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                    { win = "preview", title = "{preview}", height = 0.5, border = "top" },
                },
            },
            confirm = function(picker, item)
                if item and item.item then
                    local notif = item.item
                    local msg = notif.msg
                    if type(msg) == "table" then
                        msg = table.concat(msg, "\n")
                    end
                    -- Optionally include title
                    if notif.title and notif.title ~= "" then
                        msg = notif.title .. ": " .. msg
                    end
                    vim.fn.setreg("+", msg)
                    vim.fn.setreg("*", msg)
                    Snacks.notify.info("Copied to clipboard")
                end
                picker:close()
            end,
        })
    end, desc = "Notification History" },
    -- files
    { "<leader>,", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent({ preview = false }) end,               desc = "Recent" },
    -- Grep
    { "<leader>sl", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
    { "<leader>sb", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
    -- search
    { "<leader>sr", function() Snacks.picker.registers({ preview = false }) end,            desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds({ preview = false }) end,             desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.commands({ preview = false }) end,             desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
    { "<leader>sL", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
    { "<leader>r",  function() Snacks.picker.resume() end,                                  desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
    { "<leader>sC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
    --stylua: ignore end
}