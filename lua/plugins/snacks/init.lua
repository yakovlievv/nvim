return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		dashboard = require("plugins.snacks.dashboard"),
		picker = require("plugins.snacks.picker"),
		notifier = require("plugins.snacks.notifier"),
		terminal = require("plugins.snacks.terminal"),
		animate = { enabled = true },
		bigfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		bufdelete = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		image = require("plugins.snacks.image"),
		explorer = { enabled = false },
		scroll = require("plugins.snacks.scroll"),
		scratch = { enabled = true },
	},

	keys = {
        --stylua: ignore start
        -- Top Pickers & Explorer
        { "<C-f>",      function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<leader>/",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
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
        { "<leader>fs", function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
        -- scratch
        { "<leader>.",  function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
        -- git
        { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
        { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
        -- gh
        { "<leader>gi", function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
        { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
        { "<leader>gp", function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
        -- Grep
        { "<leader>sl", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sb", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
        -- search
        { "<leader>sR", function() Snacks.picker.registers({ preview = false }) end,            desc = "Registers" },
        -- { "<leader>s/", function() Snacks.picker.search_history({ preview = false }) end,       desc = "Search History" },
        { "<leader>sa", function() Snacks.picker.autocmds({ preview = false }) end,             desc = "Autocmds" },
        { "<leader>sc", function() Snacks.picker.commands({ preview = false }) end,             desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,                desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,              desc = "Keymaps" },
        { "<leader>sL", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>sr", function() Snacks.picker.resume() end,                                  desc = "Resume" },
        { "<leader>su", function() Snacks.picker.undo() end,                                    desc = "Undo History" },
        { "<leader>sC", function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
        -- LSP
        { "gd",         function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
        { "gD",         function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
        { "gr",         function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
        { "gai",        function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
        { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
        -- Other
        { "<leader>fR", function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },
        { "<leader>gG", function() Snacks.lazygit({ cwd = vim.fn.expand("%:h") }) end, desc = "Lazygit (cwd)" },
        { "<leader>un",  function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
        -- bufdelete
        { "<leader>x", function() Snacks.bufdelete.delete() end, desc = "Delete the buffer"},
        { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers"},
        { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers"},
        -- Terminal
        { "<C-t>", function () Snacks.terminal.toggle(vim.o.shell, {win = { border = "rounded" }}) end, mode = { "n", "t" }, desc = "Toggle floating Snacks terminal", },

        { "<leader>us", function() Snacks.toggle.option("spell",      { name = "Spelling" }):toggle() end,   desc = "Toggle Spelling" },
        { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end,                                  desc = "Toggle Diagnostics" },
        { "<leader>ul", function() Snacks.toggle.line_number():toggle() end,                                  desc = "Toggle Line Number" },
        { "<leader>uT", function() Snacks.toggle.treesitter():toggle() end,                                   desc = "Toggle Treesitter" },
        { "<leader>ub", function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end, desc = "Toggle Background" },
        { "<leader>uS", function() Snacks.toggle.scroll():toggle() end,                                       desc = "Toggle Scroll" },
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
        { "<leader>uR", function() require("symbol-usage").toggle() end, desc = "Toggle Symbol Usage" },
        { "<leader>Dpp", function() Snacks.toggle.profiler():toggle() end,            desc = "Toggle Profiler" },
        { "<leader>Dph", function() Snacks.toggle.profiler_highlights():toggle() end, desc = "Toggle Profiler Highlights" },
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode = {"n"} },
        { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },

		--stylua: ignore end
	},
}
