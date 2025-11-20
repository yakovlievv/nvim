return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	version = false,
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	event = { "VeryLazy" },
	config = function()
		local ts = require("nvim-treesitter")

		local function ensure_treesitter_cli(cb)
			if vim.fn.executable("tree-sitter") == 1 then
				return cb(true)
			end

			-- try installing with mason
			if not pcall(require, "mason") then
				return cb(false, "`mason.nvim` is disabled in your config, so we cannot install it automatically.")
			end

			-- check again since we might have installed it already
			if vim.fn.executable("tree-sitter") == 1 then
				return cb(true)
			end

			local mr = require("mason-registry")
			mr.refresh(function()
				local p = mr.get_package("tree-sitter-cli")
				if not p:is_installed() then
					vim.notify("Installing `tree-sitter-cli` with `mason.nvim`...")
					p:install(
						nil,
						vim.schedule_wrap(function(success)
							if success then
								vim.notify("Installed `tree-sitter-cli` with `mason.nvim`.")
								cb(true)
							else
								cb(false, "Failed to install `tree-sitter-cli` with `mason.nvim`.")
							end
						end)
					)
				end
			end)
		end

		ensure_treesitter_cli(function(success, err)
			if success then
				print("Tree-sitter CLI available!")
			else
				print("Tree-sitter CLI missing: " .. err)
			end
		end)

		local ensure_installed = {
			"bash",
			"c",
			"cpp",
			"lua",
			"python",
			"javascript",
			"typescript",
			"jsx",
			"tsx",
			"html",
			"css",
			"json",
			"markdown",
			"yaml",
			"gitcommit",
			"vim",
		}

		local installed = ts.get_installed()
		local not_installed = vim.tbl_filter(function(parser)
			return not vim.tbl_contains(installed, parser)
		end, ensure_installed)
		if #not_installed > 0 then
			ts.install(not_installed, { summary = true })
		end

		local augroup = vim.api.nvim_create_augroup("my.treesitter", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			group = augroup,
			callback = function(event)
				local lang = vim.treesitter.language.get_lang(event.match)
				local is_installed, _ = vim.treesitter.language.add(lang)
				if is_installed then
					local ok, _ = pcall(vim.treesitter.start, event.buf, lang)

					if not ok then
						vim.notify("Treesitter fucked up!" .. lang, vim.log.levels.INFO)
						return
					end

					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
