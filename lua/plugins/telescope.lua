return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	lazy = false,
	keys = {
		{
			"<C-f>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<C-g>",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope buffers",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Telescope help tags",
		},
		{
			"<leader>ft",
			function()
				require("telescope.builtin").builtin()
			end,
			desc = "Telescope capabilities",
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").registers()
			end,
			desc = "Telescope registers",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				local telescope = require("telescope")
				telescope.setup({
					defaults = {
						layout_config = {
							horizontal = { width = 0.9, height = 0.99, preview_width = 0.48 },
						},
					},
					extensions = {
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case",
						},
					},
				})
				telescope.load_extension("fzf")
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function(_)
						return { "--hidden", "--glob", "!.git/*" }
					end,
				},
			},
			defaults = {
				file_ignore_patterns = { ".git/" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})
	end,
}
