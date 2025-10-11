local opt = vim.opt
local g = vim.g

-- Leader keys
g.mapleader = " "
g.maplocalleader = "//"

-- UI: line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4 -- number of spaces a <Tab> counts for
opt.shiftwidth = 4 -- number of spaces used for each step of (auto)indent
opt.expandtab = true -- convert tabs to spaces
opt.smartindent = true -- smart autoindenting on new lines
opt.smarttab = true -- makes tab use shiftwidth instead of tabstop in new line

-- whitespace
opt.list = true
-- opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

-- Searching
opt.ignorecase = true -- case-insensitive search by default
opt.smartcase = true -- but case-sensitive if uppercase is used in search

-- Clipboard
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- Statusline & Display
opt.laststatus = 3 -- global statusline
opt.wrap = false -- disable line wrapping
opt.linebreak = true -- wrapping by word
opt.termguicolors = true -- enable 24-bit colors
-- opt.fillchars:append({ eob = " " }) -- hide ~ on empty lines

-- Scrolling & Signs
opt.scrolloff = 5 -- keep 5 lines visible above/below cursor
opt.signcolumn = "yes" -- always show sign column (avoid text shift)

-- Performance
opt.updatetime = 50 -- faster completion & diagnostic updates

opt.undodir = os.getenv("XDG_STATE_HOME") .. "/nvim/undo"
opt.undofile = true
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

vim.cmd([[autocmd FileType * set formatoptions-=ro]])

vim.diagnostic.config({
	virtual_text = true, -- show messages inline
	signs = true, -- keep gutter icons
	underline = true,
	update_in_insert = false,
})
