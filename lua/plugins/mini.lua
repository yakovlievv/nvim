return {
	{
		"nvim-mini/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			local surround = require("mini.surround")
			surround.setup({
				mappings = {
					add = "<A-s>a", -- Add surrounding in Normal and Visual modes
					delete = "<A-s>d", -- Delete surrounding
					find = "<A-s>f", -- Find surrounding (to the right)
					find_left = "<A-s>F", -- Find surrounding (to the left)
					highlight = "<A-s>h", -- Highlight surrounding
					replace = "<A-s>r", -- Replace surrounding

					suffix_last = "h", -- Suffix to search with "prev" method
					suffix_next = "l", -- Suffix to search with "next" method
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
