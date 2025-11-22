local set = vim.keymap.set
local opts = { silent = true, noremap = true }

-- better up and down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 1 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move selected lines
set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })
set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Indent witout reselecting everytime
set("x", ">", ">gv")
set("x", "<", "<gv")

-- Not use system clipboard
set({ "x", "n", "o" }, "<leader>p", [["_dp]])
set({ "x", "n", "o" }, "<leader>P", [["_dP]])
set({ "x", "n", "o" }, "<leader>c", [["_c]])
set({ "x", "n", "o" }, "<leader>C", [["_C]])
set({ "x", "n", "o" }, "<leader>d", [["_d]])
set({ "x", "n", "o" }, "<leader>D", [["_D]])

-- Change the word under the word
set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- set({ "n", "x", "o" }, ":", ";")
-- set({ "n", "x", "o" }, ";", ":")

-- Do J but keep the curson in place
set("n", "J", "mzJ`z")

-- Call lazy
set("n", "<leader>l", ":Lazy<CR>")

-- Reindent entire buffer while keeping cursor
set("n", "<leader>=", ":keepjumps normal! magg=G`azz<CR>")

-- chmod a file (make it executable)
set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = false })

-- resize a window
set("n", "<C-Up>", "<Cmd>resize -2<CR>", { silent = true, desc = "Decrease height" })
set("n", "<M-Down>", ":resize +2<CR>", { silent = true, desc = "Increase height" })
set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease width" })
set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase width" })

-- Toggle wrap
set("n", "<leader>W", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

-- switch to latest buffer
set("n", "<leader>bb", ":buffer #<CR>", opts)
set("n", "<C-b><C-b>", ":buffer #<CR>", opts)

-- saving and quiting
set({ "n", "v" }, "<leader>w", "<cmd>w<Cr>")
set({ "n", "v" }, "<leader>q", "<cmd>q<Cr>")
set({ "n", "v" }, "<leader>Q", "<cmd>qa<Cr>")

set({ "n", "v", "i" }, "<C-s>", "<Cmd>w<Cr>")
set({ "n", "v", "i" }, "<C-q>", "<Cmd>qa<Cr>")

-- Utilities

set("n", "<Esc>", "<cmd>nohlsearch<CR>")
set("i", "<C-p>", "<Nop>", { noremap = true, silent = true })
