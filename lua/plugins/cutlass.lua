return {
	"gbprod/cutlass.nvim",
	event = "VeryLazy",
	opts = {
		cut_key = "x", -- x = cut operator (xx cuts a line, X cuts to EOL); use dl for a plain char delete
		override_del = true, -- <Del> won't clobber the registers either
		registers = {
			select = "_",
			delete = "_",
			change = "_",
		},
	},
}
