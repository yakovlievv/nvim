return {
	{
		"nvim-mini/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
}
