set = vim.keymap.set
-- Moving lines
set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

set("n", "<leader><leader>x", "<cmd>!chmod +x %<CR>", { silent = false })
set("n", "J", "mzJ`z")

set("n", "<leader>=", ":keepjumps normal! magg=G`a<CR>")

set("n", "<leader>l", ":Lazy<CR>")
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
