-- wrapper function
local function map(modes, key, action, opts)
	local default_opts = { silent = true, noremap = true }
	-- merge tables, user opts override defaults
	local final_opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(modes, key, action, final_opts)
end

-----------------
---- MOTIONS ----
-----------------
-- This section changes some of the default motions

map({ "x", "n", "o" }, "H", "_", { desc = "Begging of the line" })
map({ "x", "n", "o" }, "L", "g_", { desc = "End of the line" })

map({ "n", "v" }, "M", "zz", { desc = "center the screen" })

map({ "n", "x" }, "<C-b>", "<C-^>", { desc = "switch to previuos buffer" })
map("i", "<C-b>", "<Esc><C-^>", { desc = "switch to previuos buffer" })

--------------------------
---- EXPERIMENTAL QOL ----
--------------------------
-- Experimental stuff that might be better in theory

map("n", "<leader>-", ":split<Cr>", { desc = "Horizontal split" })
map("n", "<leader>|", ":vsplit<Cr>", { desc = "Vertical split" })

map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-------------
---- QOL ----
-------------
-- amazing bindings that improve life

map("x", ">", ">gv")
map("x", "<", "<gv")

map("x", "<C-j>", ":m '>+1<CR>gv=gv")
map("x", "<C-k>", ":m '<-2<CR>gv=gv")
map("n", "<C-k>", ":m .-2<CR>==")
map("n", "<C-j>", ":m .+1<CR>==")

map("n", "<leader>S", ":%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>", { silent = false, desc = "Substitute word" })
map("v", "<leader>S", ':%s/<C-r>"/<C-r>"/gI<Left><Left><Left>', { silent = false, desc = "Substitute selection" })

-- not use system clipboard
map({ "x", "n", "o" }, "<leader>p", [["_dp]], { desc = "Paste without yanking" })
map({ "x", "n", "o" }, "<leader>P", [["_dP]], { desc = "Paste before (no yank)" })
map({ "x", "n", "o" }, "<leader>C", [["_C]], { desc = "Change (no yank)" })
map({ "x", "n", "o" }, "<leader>c", [["_C]], { desc = "Change to EOL (no yank)" })
map({ "x", "n", "o" }, "<leader>d", [["_d]], { desc = "Delete (no yank)" })
map({ "x", "n", "o" }, "<leader>D", [["_D]], { desc = "Delete to EOL (no yank)" })

-- join lines without moving the cursor
map("n", "J", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal! J")
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Join lines and stay in place" })

-- indent whole buffer
map("n", "<leader>=", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gg=G")
	vim.fn.winrestview(view)
end, { desc = "Reindent whole file and keep cursor" })

-- macro replay
map("n", "Q", "@q", { desc = "Replay macro q" })

-- execute stuff
map("n", "<leader>X", ":!chmod +x %<CR>", { silent = false, desc = "Make executable" })
-- delete current file (with confirmation)
map("n", "<leader>fD", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("No file to delete", vim.log.levels.WARN)
		return
	end
	local choice = vim.fn.confirm("Delete " .. vim.fn.fnamemodify(file, ":~:.") .. "?", "&Yes\n&No", 2)
	if choice ~= 1 then
		return
	end
	local ok, err = pcall(vim.fn.delete, file)
	if not ok or err == -1 then
		vim.notify("Failed to delete file", vim.log.levels.ERROR)
		return
	end
	require("snacks").bufdelete({ force = true })
	vim.notify("Deleted " .. vim.fn.fnamemodify(file, ":~:."), vim.log.levels.INFO)
end, { desc = "Delete current file (confirm)" })

-- resizin
map("n", "<M-Up>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<M-Down>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<M-Right>", ":vertical resize -5<CR>", { desc = "Decrease width" })
map("n", "<M-Left>", ":vertical resize +5<CR>", { desc = "Increase width" })

-- make it similar to emacs org
map("n", "<Tab>", "za")
map("n", "<S-Tab>", "zA")
map("n", "<C-i>", "<C-i>", { desc = "Jumplist forward" })
map("n", "<C-o>", "<C-o>", { desc = "Jumplist backward" })

-- toggle wrap
map("n", "<leader>uw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

vim.keymap.set({ "n", "i", "s" }, "<m-j>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-f>"
	end
end, { silent = true, expr = true })

vim.keymap.set({ "n", "i", "s" }, "<m-k>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-b>"
	end
end, { silent = true, expr = true })

-- diagnostics (works without LSP too)
map("n", "<leader>cd", function()
	local bufnr, winid = vim.diagnostic.open_float({ focusable = true })
	if winid then
		vim.wo[winid].winhighlight = "NormalFloat:NoiceHover"
	end
end, { desc = "Line Diagnostics" })

-- simple write and quit
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "n", "v", "i" }, "<C-q>", "<Cmd>q<Cr>", { desc = "Quit all" })

-- escape disable search-highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- this pisses me
map("i", "<C-p>", "<Nop>")

-- recentering viewport after actions
map({ "n", "x", "o" }, "<C-d>", "<C-d>zz")
map({ "n", "x", "o" }, "<C-u>", "<C-u>zz")

-- better up and down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

-- directory-aware mark jump (oil dir marks for uppercase, normal for rest)
map("n", "'", function()
	require("utils.dir_marks").jump_mark()
end, { desc = "Jump to mark (dir-aware)" })

-- better n, N
map("n", "n", "'Nn'[v:searchforward].'zvzz'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zvzz'", { expr = true, desc = "Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Jump so specific diagnostic of certain severity
local diagnostic_goto = function(next, severity)
	return function()
		pcall(vim.diagnostic.jump, {
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })

map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
