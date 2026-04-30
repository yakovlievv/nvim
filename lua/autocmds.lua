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

local folds_group = vim.api.nvim_create_augroup("my.folds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = folds_group,
	callback = function()
		if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
			vim.cmd("silent! mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = folds_group,
	callback = function()
		if vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

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
			map("n", "<leader>cR", ts_action("source.removeUnused.ts"), "Remove unused (TS)")
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
