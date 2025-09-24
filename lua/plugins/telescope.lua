return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
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
		vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set({ "n", "v" }, "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set({ "n", "v" }, "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set({ "n", "v" }, "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
