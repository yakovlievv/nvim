return {
	"supermaven-inc/supermaven-nvim",
	event = "InsertEnter",
	keys = {
		{
			"<leader>at",
			function()
				local api = require("supermaven-nvim.api")
				api.toggle()
				if api.is_running() then
					vim.notify("Supermaven enabled", vim.log.levels.INFO, { title = "Supermaven" })
				else
					vim.notify("Supermaven disabled", vim.log.levels.WARN, { title = "Supermaven" })
				end
			end,
			desc = "Toggle Supermaven",
		},
	},
	config = function()
		require("supermaven-nvim").setup({
			-- We map keys ourselves below so <Tab> can fall back to tabout.nvim.
			disable_keymaps = true,
			ignore_filetypes = {},
			color = {
				suggestion_color = "#6c7086",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false,
		})

		local preview = require("supermaven-nvim.completion_preview")

		-- <Tab>: accept the AI suggestion if one is showing, otherwise tabout/insert a tab.
		vim.keymap.set("i", "<Tab>", function()
			if preview.has_suggestion() then
				preview.on_accept_suggestion()
			else
				require("tabout").tabout()
			end
		end, { silent = true, desc = "Supermaven accept / tabout" })

		vim.keymap.set("i", "<C-]>", preview.on_dispose_inlay, { silent = true, desc = "Supermaven clear suggestion" })
	end,
}
