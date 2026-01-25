return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*", -- or specify a tag
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		build = "make", -- for fzf-native
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Telescope setup
			telescope.setup({
				defaults = {
					-- selection_caret = "➤ ",
					-- path_display = { "smart" },
					hidden = true,
					layout_strategy = "flex",
					layout_config = {
						width = 0.95,
						height = 0.95,
						-- prompt_position = "top",
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- ensure hidden files
					},
				},
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<esc>"] = require("telescope.actions").close,
					},
					n = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
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

			-- Load fzf extension if available
			pcall(telescope.load_extension, "fzf")

			local opts = { noremap = true, silent = true }

			-- Keymaps
			vim.keymap.set("n", "<C-f>", builtin.find_files, opts)
			vim.keymap.set("n", "<C-g>", builtin.live_grep, opts)

			-- "More picker" on <leader>f
			vim.keymap.set("n", "<leader>f", function()
				builtin.builtin()
			end, opts)
		end,
	},
}
