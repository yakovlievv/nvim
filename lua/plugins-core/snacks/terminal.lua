return {
	win = {
		style = "float",
		relative = "editor",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
		border = "rounded",
	},
	cwd = vim.fn.getcwd(),
}
