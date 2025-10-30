return {
	"akinsho/bufferline.nvim",
	event = "BufAdd",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		require("bufferline").setup({
			options = {
				custom_filter = function(bufnr, _)
					local ok, floating_term = pcall(vim.b[bufnr].floating_term)
					if ok and floating_term then
						return false -- hide this buffer
					end
					return true -- show all other buffers
				end,
			},
		})
	end,
}
