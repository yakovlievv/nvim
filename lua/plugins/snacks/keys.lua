local keys = {}

for _, group in ipairs({ "pickers", "git", "lsp", "toggles", "misc" }) do
	vim.list_extend(keys, require("plugins.snacks.keys." .. group))
end

return keys
