local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.9)
	local height = opts.height or math.floor(vim.o.lines * 0.9)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2 - 1)

	local buf
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	vim.api.nvim_buf_set_var(buf, "floating_term", true)

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)
	return { buf = buf, win = win }
end

local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })

		-- 🟢 Create the terminal only if not already one
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()

			-- 🟢 Set buffer options *after* terminal starts
			local buf = vim.api.nvim_get_current_buf()
			vim.bo[buf].bufhidden = "hide"

			-- 🟢 Auto-delete when closed
			vim.api.nvim_create_autocmd("TermClose", {
				buffer = buf,
				once = true,
				callback = function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(buf) then
							vim.api.nvim_buf_delete(buf, { force = true })
						end
						state.floating.buf = -1
						state.floating.win = -1
					end)
				end,
			})
		end

		vim.cmd.startinsert()
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
				-- Force close all running terminal buffers
				pcall(vim.api.nvim_buf_delete, buf, { force = true })
			end
		end
	end,
})
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
