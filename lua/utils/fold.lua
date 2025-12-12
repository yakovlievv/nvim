-- lua/utils/fold.lua
local M = {}

function M.fold_text()
    -- local line = vim.fn.getline(vim.v.foldstart)
    local count = vim.v.foldend - vim.v.foldstart + 1
    -- line = line:gsub("^%s+", "") -- remove leading spaces

    -- minimal arrow + line + fold count
    -- return "▸ " .. line .. " (" .. count .. ")"
    return "················································" .. count
end

return M
