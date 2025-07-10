local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = "//"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true

vim.opt.fillchars:append({ eob = " " }) -- hide tildies
vim.opt.clipboard = "unnamedplus" -- make it use system clipboard

opt.wrap = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
