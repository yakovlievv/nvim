return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- Virtual text shown on a closed fold: the first line + a "N lines" suffix.
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = ("  %d lines"):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "Comment" })
			return newVirtText
		end

		-- Chain lsp -> treesitter -> indent. ufo's built-in {main, fallback} table
		-- is only two levels deep, and the treesitter provider raises
		-- UfoFallbackException on buffers it can't fold (nofile, no fold query) --
		-- with nothing after it that becomes an unhandled rejection. Returning a
		-- function lets us catch each fallback and end on indent, which never throws.
		local function select_provider(bufnr)
			local ufo = require("ufo")
			local function with_fallback(err, provider)
				if type(err) == "string" and err:match("UfoFallbackException") then
					return ufo.getFolds(bufnr, provider)
				end
				return require("promise").reject(err)
			end
			return ufo.getFolds(bufnr, "lsp")
				:catch(function(err)
					return with_fallback(err, "treesitter")
				end)
				:catch(function(err)
					return with_fallback(err, "indent")
				end)
		end

		require("ufo").setup({
			provider_selector = function(_, _, _)
				return select_provider
			end,
			fold_virt_text_handler = handler,
		})
	end,
	keys = {
		{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
		{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
		{ "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
		{ "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with" },
		{
			"K",
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end,
			desc = "Peek fold / LSP Hover",
		},
	},
}
