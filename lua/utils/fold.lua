-- lua/utils/fold.lua
local M = {}

function _G.fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	local count = vim.v.foldend - vim.v.foldstart
	return {
		{ line,                        "Folded" },
		{ " [" .. count .. " lines]", "Comment" },
	}
end

return M
