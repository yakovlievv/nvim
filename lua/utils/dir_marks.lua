local M = {}

local path = vim.fn.stdpath("data") .. "/dir_marks.json"

local function load()
	local ok, content = pcall(vim.fn.readfile, path)
	if not ok or #content == 0 then
		return {}
	end
	local decoded = vim.json.decode(table.concat(content, "\n"))
	return decoded or {}
end

local function save(marks)
	vim.fn.writefile({ vim.json.encode(marks) }, path)
end

function M.set_mark()
	local dir = require("oil").get_current_dir()
	if not dir then
		vim.notify("Not in an oil buffer", vim.log.levels.WARN)
		return
	end
	local char = vim.fn.getcharstr()
	if not char:match("^%u$") then
		-- lowercase or non-alpha: fall back to normal m behavior
		vim.cmd("normal! m" .. char)
		return
	end
	local marks = load()
	marks[char] = dir
	save(marks)
	vim.notify("Dir mark " .. char .. " → " .. dir)
end

function M.jump_mark()
	local char = vim.fn.getcharstr()
	if char:match("^%u$") then
		local marks = load()
		if marks[char] then
			require("oil").open(marks[char])
			return
		end
	end
	-- fall back to normal mark jump
	local escaped = vim.fn.escape(char, "'\"\\")
	vim.cmd("normal! '" .. escaped)
end

return M
