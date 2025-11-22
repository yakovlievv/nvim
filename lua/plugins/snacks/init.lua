return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		dashboard = require("plugins.snacks.dashboard"),
		bigfile = { enabled = true },
		explorer = require("plugins.snacks.explorer"),
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		picker = require("plugins.snacks.picker"),
		bufdelete = { enabled = true },
		notifier = require("plugins.snacks.notifier"),
		quickfile = { enabled = true },
		terminal = require("plugins.snacks.terminal"),
		scope = { enabled = true },
		scroll = require("plugins.snacks.scroll"),
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},

	keys = {
        --stylua: ignore start

        -- Top Pickers & Explorer
        { "<C-f>",      function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
        { "<C-g>",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
        { "<leader>:",  function() Snacks.picker.command_history() end,                         desc = "Command History" },
        { "<leader>n",  function() Snacks.picker.notifications() end,                           desc = "Notification History" },
        -- find
        { "<leader>fb", function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        { "<leader>ff", function() Snacks.picker.files() end,                                   desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end,                                desc = "Projects" },
        { "<leader>fr", function() Snacks.picker.recent() end,                                  desc = "Recent" },
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
        { "<leader>sb", function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
        { "<leader>sw", function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
        -- search
        { "<leader>fr", function() Snacks.picker.registers() end,                               desc = "Registers" },
        { "<leader>s/", function() Snacks.picker.search_history() end,                          desc = "Search History" },
        { "<leader>fa", function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
        { "<leader>sc", function() Snacks.picker.commands() end,                                desc = "Commands" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
        { "<leader>sh", function() Snacks.picker.help() end,                                    desc = "Help Pages" },
        { "<leader>sH", function() Snacks.picker.highlights() end,                              desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end,                                   desc = "Icons" },
        { "<leader>sj", function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
        { "<leader>sl", function() Snacks.picker.loclist() end,                                 desc = "Location List" },
        { "<leader>sm", function() Snacks.picker.marks() end,                                   desc = "Marks" },
        { "<leader>sM", function() Snacks.picker.man() end,                                     desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
        { "<leader>sq", function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
        { "<leader>sR", function() Snacks.picker.resume() end,                                  desc = "Resume" },
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
        { "<leader>R", function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
        { "<leader>gB", function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end,                                        desc = "Lazygit" },
        { "<leader>gG", function() Snacks.lazygit() end, desc = "lazygit (cwd)" },
        { "<leader>U",  function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
        { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete the buffer"},
        { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers"},
        { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers"},
        { "<C-t>", function() Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd(), win = { style = "float", relative = "editor", border = "rounded" } }) end, mode = { "n", "t" }, desc = "Toggle floating Snacks terminal", },
        { "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }) end , desc = "Toggle Spelling" },
        { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }) end , desc = "Toggle Wrap" },
        { "<leader>ud", function() Snacks.toggle.diagnostics() end , desc = "Toggle Diagnostics" },
        { "<leader>ul", function() Snacks.toggle.line_number() end , desc = "Toggle Line Number" },
        {
            "<leader>uc",
            function ()
                Snacks.toggle.option("conceallevel", {
                    off = 0,
                    on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
                    name = "Conceal Level",
                }, { desc = "Toggle Conceal Level" })
            end
        },
        {
            "<leader>uA",
            function ()
                Snacks.toggle.option("showtabline", {
                    off = 0,
                    on = vim.o.showtabline > 0 and vim.o.showtabline or 2,
                    name = "Tabline",
                }, {desc = "Toggle Tabline"} )

            end
        },
        { "<leader>uT", function () Snacks.toggle.treesitter() end, {desc = "Toggle Treesitter"} },
        { "<leader>ub", function () Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }) end, {desc = "Toggle Background"} },
        { "<leader>uD", function() Snacks.toggle.dim() end , desc = "Toggle Dimming" },
        { "<leader>ua", function() Snacks.toggle.animate() end , desc = "Toggle Animate" },
        { "<leader>ug", function() Snacks.toggle.indent() end , desc = "Toggle Indent Guides" },
        { "<leader>uS", function() Snacks.toggle.scroll() end , desc = "Toggle Scroll Animations" },
        { "<leader>dpp", function() Snacks.toggle.profiler() end , desc = "Toggle Profiler" },
        { "<leader>dph", function() Snacks.toggle.profiler_highlights() end , desc = "Toggle Profiler Highlights" },

		--stylua: ignore end
	},
}
