return {
	"mbbill/undotree",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)
	end,
}
