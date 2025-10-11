local set = vim.keymap.set
local opts = { silent = true, noremap = true }

-----------------------------
-------- Visual mode --------
-----------------------------

-- add stuff
set("x", "(", "<Esc>`<i(<Esc>`>la)<Esc>")

-- Move selected lines
set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })
set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })

-- Indent witout reselecting everytime
set("x", ">", ">gv")
set("x", "<", "<gv")

-- Reselect last pasted area
set("n", "<leader>v", "`<v`>")

---------------------------------
-------- Yanking Pasting --------
---------------------------------

-- Paste and not copy
set("x", "<leader>p", [["_dP]])

-- Change the word under the cursor
set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--------------------------
-------- Motions ---------
--------------------------

-- Do J but keep the curson in place
set("n", "J", "mzJ`z")

-- Swap H L and better versions of _ and $
set({ "n", "x", "o" }, "H", "^")
set({ "n", "x", "o" }, "L", "g_")
set({ "n", "x" }, "$", "H")
set({ "n", "x" }, "_", "L")

----------------------------
-------- Utilities ---------
----------------------------

-- Just makes sense
set({ "n", "x" }, ";", ":")
set({ "n", "x" }, ":", ";")

-- Call lazy
set("n", "<leader>l", ":Lazy<CR>")

-- Reindent entire buffer while keeping cursor
set("n", "<leader>=", ":keepjumps normal! magg=G`azz<CR>")

-- chmod a file (make it executable)
set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = false })

-- resize a window
set("n", "<M-Up>", ":resize -2<CR>", { silent = true, desc = "Decrease height" })
set("n", "<M-Down>", ":resize +2<CR>", { silent = true, desc = "Increase height" })
set("n", "<M-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease width" })
set("n", "<M-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase width" })

-- Toggle wrap
set("n", "<leader>W", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap" })

--------------------------
-------- Buffers ---------
--------------------------

set("n", "<leader>bb", ":buffer #<CR>", opts)

set("n", "<M-s-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
set("n", "<M-s-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

set({ "t", "n" }, "<C-t>", "<cmd>Floaterminal<cr>")

-- Disable default tmux navigator mappings
vim.g.tmux_navigator_no_mappings = 1

-- Set custom mappings in normal mode
set("n", "<m-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
set("n", "<m-j>", "<cmd>TmuxNavigateDown<CR>", opts)
set("n", "<m-k>", "<cmd>TmuxNavigateUp<CR>", opts)
set("n", "<m-l>", "<cmd>TmuxNavigateRight<CR>", opts)

set({ "n", "v" }, "<leader>w", "<cmd>w<Cr>")

set({ "n", "v" }, "<leader>bd", "<cmd>bd<cr>")
