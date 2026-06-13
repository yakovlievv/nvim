local function goto_definition()
	vim.lsp.buf.definition({
		on_list = function(opts)
			local items = opts.items or {}
			if #items > 1 then
				-- multiple definitions: hand off to the picker
				Snacks.picker.lsp_definitions()
				return
			end
			-- single (or zero) definition: jump directly
			vim.fn.setqflist({}, " ", opts)
			vim.cmd.cfirst()
		end,
	})
end

return {
    --stylua: ignore start
    { "gd",         goto_definition,                                      desc = "Goto Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                desc = "References" },
    { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming" },
    { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "<leader>cl", function() Snacks.picker.lsp_config() end,            desc = "Lsp Info" },
	--stylua: ignore end
}
