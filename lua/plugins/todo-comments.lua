return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	cmd = { "TodoTrouble", "TodoQuickFix", "TodoLocList" },
	opts = {},
	keys = {
		{
			"]T",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next TODO",
		},
		{
			"[T",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Prev TODO",
		},
		{ "<leader>ct", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
		{ "<leader>cT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		{
			"<leader>st",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo",
		},
		{
			"<leader>sT",
			function()
				Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end,
			desc = "Todo/Fix/Fixme",
		},
	},
}
