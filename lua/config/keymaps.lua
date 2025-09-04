set = vim.keymap.set
-- Moving lines
set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = false })
set("n", "J", "mzJ`z")

set("n", "<leader>=", ":keepjumps normal! magg=G`azz<CR>")

set("n", "<leader>l", ":Lazy<CR>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap.set("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
keymap.set("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")
-- set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- set("n", "n", "nzzzv")
-- set("n", "N", "Nzzzv")

-- set("n", "=ap", "ma=ap'a")

-- greatest remap ever
-- set("x", "<leader>p", [["_dP]])
-- set({ "n", "v" }, "<leader>y", [["+y]])
-- set("n", "<leader>Y", [["+Y]])

-- set({ "n", "v" }, "<leader>d", '"_d')


-- set("n", "<leader>f", function()
    --   require("conform").format({ bufnr = 0 })
    -- end)

    -- set("n", "<C-k>", "<cmd>cnext<CR>zz")
    -- set("n", "<C-j>", "<cmd>cprev<CR>zz")
    -- set("n", "<leader>k", "<cmd>lnext<CR>zz")
    -- set("n", "<leader>j", "<cmd>lprev<CR>zz")

    -- set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
