return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPost",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				names = false,
				suppress_deprecation = true,
			},
		})
	end,
}
