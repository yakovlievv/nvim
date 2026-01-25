-- wrapper function
local function map(modes, key, action, opts)
	local default_opts = { silent = true, noremap = true }
	-- merge tables, user opts override defaults
	local final_opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.keymap.set(modes, key, action, final_opts)
end

-- better up and down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

-- better n, N
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

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
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

map("n", "<C-k>", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "<C-j>", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Move selected lines
map("x", "K", ":m '<-2<cr>gv=gv")
map("x", "J", ":m '>+1<CR>gv=gv")

-- Indent witout reselecting everytime
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Not use system clipboard
map({ "x", "n", "o" }, "<leader>p", [["_dhp]])
map({ "x", "n", "o" }, "<leader>P", [["_dhP]])
map({ "x", "n", "o" }, "<leader>c", [["_c]])
map({ "x", "n", "o" }, "<leader>C", [["_C]])
map({ "x", "n", "o" }, "<leader>d", [["_d]])
map({ "x", "n", "o" }, "<leader>D", [["_D]])

-- Change the word under the word
map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>S", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])

-- set({ "n", "x", "o" }, ":", ";")
-- set({ "n", "x", "o" }, ";", ":")

-- Do J but keep the curson in place
map("n", "J", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal! J")
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Join lines and stay in place" })

-- Call lazy
map("n", "<leader>l", "<cmd>Lazy<CR>")

-- Reindent entire buffer while keeping cursor
map("n", "<leader>=", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gg=G")
	vim.fn.winrestview(view)
end, { desc = "Reindent whole file and keep cursor" })

-- chmod a file (make it executable)
map("n", "<leader>x", ":!chmod +x %<CR>", { silent = false })

-- resize a window
map("n", "<M-Up>", ":resize -2<CR>", { desc = "Decrease height" })
map("n", "<M-Down>", ":resize +2<CR>", { desc = "Increase height" })
map("n", "<M-Left>", ":vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<M-Right>", ":vertical resize +2<CR>", { desc = "Increase width" })

-- Toggle wrap
map("n", "<leader>W", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- switch to latest buffer
-- map("n", "<leader>bb", ":buffer #<CR>")

-- saving and quiting
-- set({ "n", "v" }, "<leader>w", "<cmd>w<Cr>")
-- set({ "n", "v" }, "<leader>q", "<cmd>q<Cr>")
-- set({ "n", "v" }, "<leader>Q", "<cmd>qa<Cr>")
--
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- map({ "n", "v", "i" }, "<C-q>", "<Cmd>qa<Cr>")

-- these just make sense don't they?
-- map({ "n", "x", "o" }, "<S-h>", "_")
-- map({ "n", "x", "o" }, "<S-l>", "g_")

-- Close floating windows in insert mode with K
map(
	"i",
	"<A-k>",
	'<Cmd>lua for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do if vim.api.nvim_win_is_valid(win) then local cfg = vim.api.nvim_win_get_config(win) if cfg.relative ~= "" then vim.api.nvim_win_close(win, true) end end end <CR>'
)

-- Close only floating windows safely in insert mode
-- Utilities

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("i", "<C-p>", "<Nop>")

-- uninstall treesitter parsers
map(
	"n",
	"<leader>tu",
	[[:lua require("nvim-treesitter").uninstall(require("nvim-treesitter").get_installed(), { summary = true })]]
)

map("n", "<leader>E", ":Ex<Cr>")
-- Set({ "n" }, "<leader>c", "1z=")
