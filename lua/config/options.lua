local opt = vim.opt
local g = vim.g
local o = vim.o

-- Leader keys
g.mapleader = " "
g.maplocalleader = "\\"

opt.title = true

opt.backup = false

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "cursor"

opt.inccommand = "split"
opt.breakindent = true

-- UI: line numbers
opt.number = true
opt.relativenumber = true

-- Enable cursor line
opt.cursorline = true
opt.backspace = { "start", "eol", "indent" }

-- o.winborder = "rounded"

-- Indentation
opt.tabstop = 4 -- number of spaces a <Tab> counts for
opt.shiftwidth = 4 -- number of spaces used for each step of (auto)indent
opt.expandtab = true -- convert tabs to spaces
opt.smartindent = true -- smart autoindenting on new lines
opt.smarttab = true -- makes tab use shiftwidth instead of tabstop in new line

o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- whitespace
opt.list = false
-- opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

o.swapfile = false

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
-- opt.fillchars:append({ eob = " " })

-- Scrolling & Signs
opt.scrolloff = 5 -- keep 5 lines visible above/below cursor
opt.signcolumn = "yes" -- always show sign column (avoid text shift)

-- Performance
opt.updatetime = 50 -- faster completion & diagnostic updates

opt.undodir = os.getenv("XDG_STATE_HOME") .. "/nvim/undo"
opt.undofile = true
opt.hlsearch = true
opt.incsearch = true

_G.ICONS = {
	diagnostics = {
		error = "", -- 
		warn = "", -- 
		info = "", -- 
		hint = "", -- 󰌵
	},
	git_diff = {
		added = " ",
		modified = " ",
		removed = " ",
	},
}

vim.diagnostic.config({
	virtual_text = true, -- show messages inline
	signs = {
		text = {

			[vim.diagnostic.severity.ERROR] = ICONS.diagnostics.error,
			[vim.diagnostic.severity.WARN] = ICONS.diagnostics.warn,
			[vim.diagnostic.severity.INFO] = ICONS.diagnostics.info,
			[vim.diagnostic.severity.HINT] = ICONS.diagnostics.hint,
		},
	},
	underline = true,
	update_in_insert = false,
	-- float = { border = "rounded" },
})
