-- Inlay hints available but disabled by default; toggle with <leader>ch

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
		vim.wo.wrap = true -- turn on line wrapping
		vim.wo.linebreak = true -- break lines at word boundaries (optional, nicer look)
	end,
})

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
			vim.system(
				{ "sh", "-c",
				'find '
				.. data_dir .. '/site/parser '
				.. data_dir .. '/lazy/LuaSnip '
				.. data_dir .. '/lazy/blink.cmp/target/release '
				.. '-name "*.so" -o -name "*.dylib" 2>/dev/null | xargs -I{} codesign --force --sign - {}'
			},
				{ text = true },
				function(result)
					if result.code == 0 then
						vim.schedule(function()
							vim.notify("Native libs re-signed (macOS)", vim.log.levels.DEBUG)
						end)
					end
				end
			)
		end,
	})
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.comments", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("my.indenting", { clear = true }),
	pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})
