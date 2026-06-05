return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			function()
				require("edgy").toggle("left")
			end,
			desc = "Toggle Sidebar",
		},
	},
	init = function()
		-- recommended for a stable edgebar layout
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = {
		animate = { enabled = false },
		options = {
			left = { size = 40 },
		},
		left = {
			-- Neo-Tree filesystem (the main, expanded section)
			{
				title = "Neo-Tree",
				ft = "neo-tree",
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "filesystem"
				end,
				pinned = true,
				open = "Neotree position=left filesystem",
				size = { height = 0.5 },
			},
			-- Neo-Tree git status (collapsed on start)
			{
				title = "Git",
				ft = "neo-tree",
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "git_status"
				end,
				pinned = true,
				collapsed = true,
				open = "Neotree position=left git_status",
			},
			-- Neo-Tree open buffers (collapsed on start)
			{
				title = "Buffers",
				ft = "neo-tree",
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "buffers"
				end,
				pinned = true,
				collapsed = true,
				open = "Neotree position=left buffers",
			},
			-- Outline via trouble.nvim symbols (collapsed on start)
			{
				title = "Outline",
				ft = "trouble",
				filter = function(_, win)
					return vim.w[win].trouble
						and vim.w[win].trouble.mode == "symbols"
						and vim.w[win].trouble.type == "split"
						and vim.w[win].trouble.relative == "editor"
						and not vim.w[win].trouble_preview
				end,
				pinned = true,
				collapsed = true,
				open = "Trouble symbols toggle focus=false",
			},
		},
		-- move between edgebar windows with <C-w> j/k like regular splits
		keys = {
			["<c-w>k"] = function(win)
				win:prev({ visible = true, focus = true })
			end,
			["<c-w>j"] = function(win)
				win:next({ visible = true, focus = true })
			end,
		},
		exit_when_last = true,
	},
}
