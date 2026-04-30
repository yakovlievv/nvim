return {
	"Wansmer/symbol-usage.nvim",
	event = "LspAttach",
	config = function()
		local function text_format(symbol)
			local fragments = {}

			if symbol.references and symbol.references > 0 then
				local count = symbol.references <= 99 and symbol.references or "99+"
				table.insert(fragments, { "󰌹 " .. count .. " refs", "SymbolUsageRef" })
			end

			if symbol.implementation and symbol.implementation > 0 then
				local count = symbol.implementation <= 99 and symbol.implementation or "99+"
				table.insert(fragments, { "󰡱 " .. count .. " impls", "SymbolUsageImpl" })
			end

			local result = {}
			for i, frag in ipairs(fragments) do
				table.insert(result, frag)
				if i < #fragments then
					table.insert(result, { "  ", "NonText" })
				end
			end
			return result
		end

		require("symbol-usage").setup({
			text_format = text_format,
			vt_position = "above",
			references = { enabled = true, include_declaration = false },
			definition = { enabled = false },
			implementation = { enabled = true },
			disable = { filetypes = { "dockerfile", "yaml", "json", "toml" } },
		})
	end,
}
