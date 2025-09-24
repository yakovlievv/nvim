local set = vim.keymap.set

-------- Visual mode stuff --------

-- Move selected lines
set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Indent witout reselecting everytime
set("v", ">", ">gv")
set("v", "<", "<gv")

-- Reselect last pasted area
set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
	expr = true,
	desc = "reselect last pasted area",
})

-------- Yanking Pasting --------
-- Paste and not copy
set("x", "<leader>p", [["_dP]])

set("n", "J", "mzJ`z")

-- =========================
-- Reindent entire buffer while keeping cursor
-- =========================
set("n", "<leader>=", ":keepjumps normal! magg=G`azz<CR>")
set("n", "<leader>l", ":Lazy<CR>")

set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

set({ "n", "x" }, "H", "^")
set({ "n", "x" }, "L", "g_")

set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = false })

set("n", "<M-Up>", ":resize -2<CR>", { silent = true, desc = "Decrease height" })
set("n", "<M-Down>", ":resize +2<CR>", { silent = true, desc = "Increase height" })
set("n", "<M-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease width" })
set("n", "<M-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Increase width" })

-- Tmux sessionizer
-- set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Search navigation
-- set("n", "n", "nzzzv")
-- set("n", "N", "Nzzzv")

-- Reindent paragraph
-- set("n", "=ap", "ma=ap'a")

-- Greatest remap ever
-- set("x", "<leader>p", [["_dP]])
-- set({ "n", "v" }, "<leader>y", [["+y]])
-- set("n", "<leader>Y", [["+Y]])

-- Delete without overwriting registers
-- set({ "n", "v" }, "<leader>d", '"_d')

-- Formatting with conform.nvim
-- set("n", "<leader>f", function()
--     require("conform").format({ bufnr = 0 })
-- end)

-- Quickfix and location list navigation
-- set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")
