return {
	"yetone/avante.nvim",
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false,
	opts = {
		instructions_file = "avante.md",
		provider = "openai",
		auto_suggestions_provider = "openai",
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				api_key = os.getenv("OPENAI_API_KEY"),
				model = "gpt-4o-mini",
				chat_model = "gpt-4o-mini",
			},
		},
		input = {
			provider = "snacks",
			provider_opts = {
				-- Additional snacks.input options
				title = "Avante Input",
				icon = " ",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
