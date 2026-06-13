vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights text when yanking",
	group = vim.api.nvim_create_augroup("my.yank-highlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("my.markdown-wrap", { clear = true }),
	desc = "Enable wrap for all Markdown files",
	callback = function()
		vim.wo.wrap = true
		vim.wo.linebreak = true
	end,
})

-- Per-filetype indent so the editor matches what the formatter emits.
-- Avoids cursor jumps / fake diffs caused by indent mismatch on save.
local indent_groups = {
	-- 2 spaces — prettier/standard defaults for the web stack
	["2"] = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"json",
		"jsonc",
		"json5",
		"yaml",
		"html",
		"css",
		"scss",
		"less",
		"graphql",
		"markdown",
	},
	-- 4 spaces — python/clang/shell stay at the existing global
}

local indent_group = vim.api.nvim_create_augroup("my.indent-by-ft", { clear = true })
for width, fts in pairs(indent_groups) do
	vim.api.nvim_create_autocmd("FileType", {
		pattern = fts,
		group = indent_group,
		callback = function()
			local n = tonumber(width)
			vim.bo.tabstop = n
			vim.bo.shiftwidth = n
			vim.bo.softtabstop = n
			vim.bo.expandtab = true
		end,
	})
end

-- macOS: re-sign native .so/.dylib files after lazy installs/updates to prevent
-- code signature crashes (EXC_BAD_ACCESS / SIGKILL Code Signature Invalid)
if vim.fn.has("mac") == 1 then
	vim.api.nvim_create_autocmd("User", {
		pattern = { "LazyInstall", "LazyUpdate", "LazySync", "LazyRestore" },
		group = vim.api.nvim_create_augroup("my.codesign", { clear = true }),
		desc = "Re-sign native libs after lazy operations",
		callback = function()
			local data_dir = vim.fn.stdpath("data")
			vim.system({
				"sh",
				"-c",
				"find "
					.. data_dir
					.. "/site/parser "
					.. data_dir
					.. "/lazy/LuaSnip "
					.. data_dir
					.. "/lazy/blink.cmp/target/release "
					.. '-name "*.so" -o -name "*.dylib" 2>/dev/null | xargs -I{} codesign --force --sign - {}',
			}, { text = true }, function(result)
				if result.code == 0 then
					vim.schedule(function()
						vim.notify("Native libs re-signed (macOS)", vim.log.levels.DEBUG)
					end)
				end
			end)
		end,
	})
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.comments", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp-keymaps", { clear = true }),
	callback = function(ev)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
		end

		map("n", "<leader>ch", function()
			Snacks.toggle.inlay_hints():toggle()
		end, "Toggle Inlay Hints")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "gd", vim.lsp.buf.definition, "Goto Definition")

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.name == "vtsls" then
			local function ts_action(name)
				return function()
					vim.lsp.buf.code_action({
						apply = true,
						context = { only = { name }, diagnostics = {} },
					})
				end
			end
			map("n", "<leader>cM", ts_action("source.addMissingImports.ts"), "Add missing imports (TS)")
			map("n", "<leader>cD", ts_action("source.fixAll.ts"), "Fix all (TS)")
			-- map("n", "<leader>cR", ts_action("source.removeUnused.ts"), "Remove unused (TS)")
		end
	end,
})

-- Auto-reload files changed outside nvim when focus returns
vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "CursorHold" }, {
	group = vim.api.nvim_create_augroup("my.checktime", { clear = true }),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("silent! checktime")
		end
	end,
})

-- Auto-equalize split sizes when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("my.resize-splits", { clear = true }),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Close these UI panels with plain `q`
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.close-with-q", { clear = true }),
	pattern = {
		"help",
		"lspinfo",
		"startuptime",
		"checkhealth",
		"qf",
		"git",
		"query",
		"notify",
		"noice",
		"DiffviewFiles",
		"DiffviewFileHistory",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
	},
	callback = function(ev)
		vim.bo[ev.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true, nowait = true })
	end,
})

-- Persist cursor, scroll and fold state per file via view files (viewoptions in
-- options.lua). loadview restores ONCE per buffer load, guarded by a buffer-local
-- flag, and runs SYNCHRONOUSLY (no vim.schedule). That guard is the fix for the
-- old jumping bug: without it, loadview re-fired on every window re-entry and
-- snapped the cursor/scroll back after you'd moved. It also replaces the old
-- shada-mark cursor restore — one source of truth, so nothing fights over the
-- cursor.
local view_ignore_ft = { gitcommit = true, gitrebase = true, commit = true }

local function view_eligible(buf)
	-- Only real, on-disk, editable file buffers — skip terminals/nofile/help/etc.
	if vim.bo[buf].buftype ~= "" or not vim.bo[buf].modifiable or vim.bo[buf].filetype == "" then
		return false
	end
	if view_ignore_ft[vim.bo[buf].filetype] then
		return false
	end
	local name = vim.api.nvim_buf_get_name(buf)
	return name ~= "" and vim.fn.filereadable(name) == 1
end

local view_group = vim.api.nvim_create_augroup("my.view", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost" }, {
	group = view_group,
	desc = "Save cursor/scroll/fold view",
	callback = function(ev)
		if vim.b[ev.buf].view_activated then
			vim.cmd.mkview({ mods = { emsg_silent = true } })
		end
	end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = view_group,
	desc = "Restore cursor/scroll/fold view (once per buffer load)",
	callback = function(ev)
		if not vim.b[ev.buf].view_activated and view_eligible(ev.buf) then
			vim.b[ev.buf].view_activated = true
			vim.cmd.loadview({ mods = { emsg_silent = true } })
		end
	end,
})

-- Auto-create missing parent directories on :w
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("my.auto-create-dir", { clear = true }),
	callback = function(ev)
		if ev.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(ev.match) or ev.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})


-- <leader>w (visual): instantly wrap a JSX selection in a tag, no menu.
-- Stashes the selection via LuaSnip's cut_keys, then expands a tag snippet
-- that reads it back -- the appended <cmd> fires after the stash completes.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascriptreact", "typescriptreact" },
	group = vim.api.nvim_create_augroup("my.jsx-wrap", { clear = true }),
	desc = "<leader>w wraps a visual JSX selection in a tag",
	callback = function(ev)
		vim.keymap.set("x", "<leader>w", function()
			-- LuaSnip is lazy-loaded on InsertEnter; ensure it's available
			if not package.loaded["luasnip"] then
				require("lazy").load({ plugins = { "LuaSnip" } })
			end
			local keys = require("luasnip.util.select").cut_keys
				.. "<cmd>lua require('utils.jsxwrap')()<cr>"
			vim.api.nvim_feedkeys(
				vim.api.nvim_replace_termcodes(keys, true, true, true),
				"n",
				false
			)
		end, { buffer = ev.buf, desc = "Wrap JSX selection in tag" })
	end,
})
