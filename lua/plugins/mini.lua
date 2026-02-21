return {
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			local surround = require("mini.surround")
			surround.setup({
				mappings = {
					add = "ysa",      -- ysa{motion}{char}  e.g. ysaW"
					delete = "ysd",   -- ysd{char}
					find = "ysf",
					find_left = "ysF",
					highlight = "ysh",
					replace = "ysr",  -- ysr{old}{new}
					suffix_last = "h",
					suffix_next = "l",
				},
			})
			-- vim.keymap.del("n", "sn")
		end,
	},
	{
		"nvim-mini/mini.ai",
		version = "*",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			local ai = require("mini.ai")
			ai.setup({
				n_lines = 500,
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
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
