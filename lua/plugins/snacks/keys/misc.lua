return {
    -- stylua: ignore start
	-- scratch
	{ "<leader>fs", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
	{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
	-- rename
	{ "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode = { "n" } },
	-- bufdelete
	{ "<leader>x", function() Snacks.bufdelete.delete() end, desc = "Delete the buffer" },
	{ "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete all buffers" },
	{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete other buffers" },
	--stylua: ignore end
	-- terminal
	{
		"<C-t>",
		function()
			Snacks.terminal.toggle(vim.o.shell, {
				win = {
					border = "rounded",
					style = "float",
					relative = "editor",
					width = math.floor(vim.o.columns * 0.90),
					height = math.floor(vim.o.lines * 0.90),
				},
			})
		end,
		mode = { "n", "t" },
		desc = "Toggle floating Snacks terminal",
	},
    -- stylua: ignore start
	{ "<leader>t", function() Snacks.terminal.toggle() end, mode = { "n" }, desc = "Toggle snacks split terminal" },
    -- words
	{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
	{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	--stylua: ignore end
}
