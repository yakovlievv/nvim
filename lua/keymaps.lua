local set = vim.keymap.set
local opts = { silent = true, noremap = true }

-- better up and down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down" })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up" })

set("n", "+", "<C-a>")
set("n", "-", "<C-x>")

-- better n, N
set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

set("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

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

set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, opts)
set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, opts)

set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

set("n", "<C-k>", vim.cmd.cprev, { desc = "Previous Quickfix" })
set("n", "<C-j>", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Move selected lines
set("x", "K", ":m '<-2<cr>gv=gv", { silent = true })
set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Indent witout reselecting everytime
set("x", ">", ">gv")
set("x", "<", "<gv")

-- Not use system clipboard
set({ "x", "n", "o" }, "<leader>p", [["_dhp]])
set({ "x", "n", "o" }, "<leader>P", [["_dhP]])
set({ "x", "n", "o" }, "<leader>c", [["_c]])
set({ "x", "n", "o" }, "<leader>C", [["_C]])
set({ "x", "n", "o" }, "<leader>d", [["_d]])
set({ "x", "n", "o" }, "<leader>D", [["_D]])

-- Change the word under the word
set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
set("v", "<leader>S", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]])

-- set({ "n", "x", "o" }, ":", ";")
-- set({ "n", "x", "o" }, ";", ":")

-- Do J but keep the curson in place
set("n", "J", "mzJ`z")

-- Call lazy
set("n", "<leader>l", "<cmd>Lazy<CR>")

-- Reindent entire buffer while keeping cursor
vim.keymap.set("n", "<leader>=", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gg=G")
	vim.fn.winrestview(view)
end, { desc = "Reindent whole file and keep cursor" })

-- chmod a file (make it executable)
set("n", "<leader><leader>x", ":!chmod +x %<CR>", { silent = false })

-- resize a window
set("n", "<C-Up>", "<Cmd>resize -2<CR>", { silent = true, desc = "Decrease height" })
set("n", "<M-Down>", ":resize +2<CR>", { silent = true, desc = "Increase height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase width" })

-- Toggle wrap
set("n", "<leader>W", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

set("n", "<leader>rn", vim.lsp.buf.rename, opts)
set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

-- switch to latest buffer
set("n", "<leader>bb", ":buffer #<CR>", opts)
set("n", "<C-b><C-b>", ":buffer #<CR>", opts)

-- saving and quiting
-- set({ "n", "v" }, "<leader>w", "<cmd>w<Cr>")
-- set({ "n", "v" }, "<leader>q", "<cmd>q<Cr>")
-- set({ "n", "v" }, "<leader>Q", "<cmd>qa<Cr>")
--
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
set({ "n", "v", "i" }, "<C-q>", "<Cmd>qa<Cr>")

-- these just make sense don't they?
set({ "n", "x", "o" }, "<S-l>", "g_")
set({ "n", "x", "o" }, "<S-h>", "_")

-- Close floating windows in insert mode with K
set(
	"i",
	"<A-k>",
	'<Cmd>lua for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do if vim.api.nvim_win_is_valid(win) then local cfg = vim.api.nvim_win_get_config(win) if cfg.relative ~= "" then vim.api.nvim_win_close(win, true) end end end <CR>',
	{ noremap = true, silent = true }
)

-- Close only floating windows safely in insert mode
-- Utilities

set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("i", "<C-p>", "<Nop>", { noremap = true, silent = true })

-- uninstall treesitter parsers
set(
	"n",
	"<leader>tu",
	[[:lua require("nvim-treesitter").uninstall(require("nvim-treesitter").get_installed(), { summary = true })]]
)
set({ "n" }, "<leader>c", "1z=")
