-- lua/utils/fold.lua
local M = {}

function _G.fold_text()
	local line = vim.fn.getline(vim.v.foldstart)
	return "  " .. line
end

return M
