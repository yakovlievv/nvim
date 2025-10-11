return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				-- You dont need to set any of these options. These are the default ones. Only
				-- the loading is important
				require("telescope").setup({
					defaults = {
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.99,
								preview_width = 0.48,
							},
						},
					},
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
				})
				-- To get fzf loaded and working with telescope, you need to call
				-- load_extension, somewhere after setup function:
				require("telescope").load_extension("fzf")
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
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

		-- Your leader mappings
		vim.keymap.set({ "n", "v" }, "<C-f>", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set({ "n", "v" }, "<C-g>", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set({ "n", "v" }, "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set({ "n", "v" }, "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		vim.keymap.set({ "n", "v" }, "<leader>ft", builtin.builtin, { desc = "Telescope capabilities" })
		vim.keymap.set({ "n", "v" }, "<leader>fr", builtin.registers, { desc = "Telescope registers" })
	end,
}
