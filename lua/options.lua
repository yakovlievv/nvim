-- Disable unused built-in plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_tohtml = 1
vim.g.loaded_tutor = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local opt = vim.opt
local g = vim.g

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

-- Indentation
opt.tabstop = 4 -- number of spaces a <Tab> counts for
opt.shiftwidth = 4 -- number of spaces used for each step of (auto)indent
opt.expandtab = true -- convert tabs to spaces
opt.smartindent = true -- smart autoindenting on new lines
opt.smarttab = true -- makes tab use shiftwidth instead of tabstop in new line

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- whitespace
opt.list = false
-- opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

opt.swapfile = false

-- Searching
opt.ignorecase = true -- case-insensitive search by default
opt.smartcase = true -- but case-sensitive if uppercase is used in search

-- Clipboard
opt.clipboard = "unnamedplus" -- sync with system clipboard

-- Statusline & Display
opt.laststatus = 3 -- global statusline
opt.wrap = false -- disable line wrapping
opt.termguicolors = true -- enable 24-bit colors
-- opt.fillchars:append({ eob = " " })

-- Scrolling & Signs
opt.scrolloff = 5 -- keep 5 lines visible above/below cursor
opt.signcolumn = "yes" -- always show sign column (avoid text shift)

-- Performance
opt.updatetime = 150 -- faster completion & diagnostic updates
opt.timeoutlen = 400

local undodir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undodir, "p") -- make sure it exists
vim.opt.showmode = false
opt.undodir = undodir
opt.undofile = true -- enable persistent undo
opt.hlsearch = true
opt.incsearch = true

local icons = require("utils.icons")
vim.diagnostic.config({
	virtual_text = true, -- show messages inline
	signs = {
		text = {

			[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "none" },
})

vim.filetype.add({
	extension = { mdx = "markdown.mdx" },
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		[".gitlab-ci.yml"] = "yaml.gitlab",
	},
	pattern = {
		[".*helm.*values.*%.ya?ml"] = "yaml.helm-values",
	},
})
