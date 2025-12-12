local M = {}
-- Helper function to format with highlights
function M.format_hl(text, hl_group)
	if not hl_group or hl_group == "" then
		return text
	end
	return "%#" .. hl_group .. "#" .. text .. "%*"
end
vim.opt.showmode = false

-- Pretty path component
function M.pretty_path()
	local path = vim.fn.expand("%:p")
	if path == "" then
		return ""
	end

	-- Get relative path from cwd
	local cwd = vim.fn.getcwd()
	if path:find(cwd, 1, true) == 1 then
		path = path:sub(#cwd + 2)
	end

	-- Split path into parts
	local sep = package.config:sub(1, 1)
	local parts = vim.split(path, "[\\/]")

	-- Shorten if too long (keep first, last 2, and ellipsis)
	if #parts > 3 then
		parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
	end

	-- Build the path with separate highlights
	if #parts == 1 then
		-- Only filename, no directory
		local hl = vim.bo.modified and "Constant" or "Bold"
		return M.format_hl(parts[1], hl)
	else
		-- Separate directory and filename
		local filename = table.remove(parts)
		local dirpath = table.concat(parts, sep) .. sep

		-- Apply different highlights
		local dir_hl = "Comment" -- Dimmed for directory
		local file_hl = vim.bo.modified and "Constant" or "Bold"

		return M.format_hl(dirpath, dir_hl) .. M.format_hl(filename, file_hl)
	end
end

return M
