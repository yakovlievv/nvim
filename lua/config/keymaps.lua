local set = vim.keymap.set

-----------------------------
-------- Visual mode --------
-----------------------------

-- add stuff
-- set("x", "(", "<Esc>`<i(<Esc>`>la)<Esc>")
-- set("x", "{", "<Esc>`<i{<Esc>`>la{<Esc>")
-- set("x", "[", "<Esc>`<i[<Esc>`>la[<Esc>")
-- set("x", "<", "<Esc>`<i<<Esc>`>la<<Esc>")
-- set("x", '"', '<Esc>`<i"<Esc>`>la"<Esc>')
-- set("x", "'", "<Esc>`<i'<Esc>`>la'<Esc>")

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

-- highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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
