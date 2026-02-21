-- wrapper function
local function map(modes, key, action, opts)
	local default_opts = { silent = true, noremap = true }
	-- merge tables, user opts override defaults
	local final_opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(modes, key, action, final_opts)
end

-- experimental shit
map({ "n", "x", "o" }, "H", "_")
map({ "n", "x", "o" }, "L", "g_")

-- quickfix movements
map("n", "<C-k>", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "<C-j>", vim.cmd.cnext, { desc = "Next Quickfix" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Move selected lines
map("x", "K", ":m '<-2<cr>gv=gv")
map("x", "J", ":m '>+1<CR>gv=gv")

-- indent witout reselecting everytime
map("x", ">", ">gv")
map("x", "<", "<gv")

-- not use system clipboard
map({ "x", "n", "o" }, "<leader>vp", [["_dp]], { desc = "Paste without yanking" })
map({ "x", "n", "o" }, "<leader>vP", [["_dP]], { desc = "Paste before (no yank)" })
map({ "x", "n", "o" }, "<leader>vc", [["_c]], { desc = "Change (no yank)" })
map({ "x", "n", "o" }, "<leader>vC", [["_C]], { desc = "Change to EOL (no yank)" })
map({ "x", "n", "o" }, "<leader>vd", [["_d]], { desc = "Delete (no yank)" })
map({ "x", "n", "o" }, "<leader>vD", [["_D]], { desc = "Delete to EOL (no yank)" })

-- change the word under the word or the highlight
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word" })
map("v", "<leader>S", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Substitute selection" })

-- join lines without moving the cursor
map("n", "J", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal! J")
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Join lines and stay in place" })

-- call lazy
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

-- indent whole buffer
map("n", "<leader>=", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gg=G")
	vim.fn.winrestview(view)
end, { desc = "Reindent whole file and keep cursor" })

-- execute stuff
map("n", "<leader>x", ":!chmod +x %<CR>", { silent = false, desc = "Make executable" })

-- resizin
map("n", "<M-Up>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<M-Down>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<M-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<M-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- make it similar to emacs org
map("n", "<Tab>", "za")
map("n", "<S-Tab>", "zA")

-- toggle wrap
map("n", "<leader>W", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

-- code group
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>ch", function()
	Snacks.toggle.inlay_hints():toggle()
end, { desc = "Toggle Inlay Hints" })

-- simple write and quit
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map({ "n", "v", "i" }, "<C-q>", "<Cmd>qa<Cr>", { desc = "Quit all" })

-- escape disable search-highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- this pisses me off
map("i", "<C-p>", "<Nop>")

-- uninstall treesitter parsers
map(
	"n",
	"<leader>tu",
	[[:lua require("nvim-treesitter").uninstall(require("nvim-treesitter").get_installed(), { summary = true })]], { desc = "Uninstall all parsers" }
)

-- recentering viewport after actions
map({ "n", "x", "o" }, "<C-d>", "<C-d>zz")
map({ "n", "x", "o" }, "<C-u>", "<C-u>zz")

-- better up and down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

-- better n, N
map("n", "n", "'Nn'[v:searchforward].'zvzz'", { expr = true, desc = "Next Search Result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zvzz'", { expr = true, desc = "Prev Search Result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Jump so specific diagnostic of certain severity
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
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
