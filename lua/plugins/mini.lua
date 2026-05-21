return {
	{
		"nvim-mini/mini.surround",
		version = "*",
		keys = {
			{ "gsa", mode = { "n", "x" }, desc = "Add surrounding" },
			{ "gsd", desc = "Delete surrounding" },
			{ "gsf", desc = "Find surrounding (right)" },
			{ "gsF", desc = "Find surrounding (left)" },
			{ "gsh", desc = "Highlight surrounding" },
			{ "gsr", desc = "Replace surrounding" },
		},
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					suffix_last = "h",
					suffix_next = "l",
				},
			})
		end,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "LazyFile",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
				},
			})
		end,
	},
	{
		"nvim-mini/mini.icons",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.icons").setup({})
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
}
