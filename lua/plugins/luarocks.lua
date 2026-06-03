-- Bootstraps luarocks and installs rocks for neovim's lua runtime.
-- Currently only needed for nvim-spider's UTF-8 (Unicode word motion) support.
return {
	"vhyrro/luarocks.nvim",
	priority = 1000, -- must load before any plugin that requires a rock
	lazy = false,
	config = function()
		-- luarocks vendors dkjson under luarocks/vendor/, but its package loader
		-- does `require("dkjson")` (plain), so it fails and prints a scary error.
		-- The rock paths are still wired up regardless, but preloading the
		-- vendored copy silences the loader error.
		local vendor = vim.fn.stdpath("data")
			.. "/lazy/luarocks.nvim/.rocks/share/lua/5.1/luarocks/vendor/dkjson.lua"
		if vim.uv.fs_stat(vendor) then
			package.preload["dkjson"] = function()
				return loadfile(vendor)()
			end
		end

		require("luarocks-nvim").setup({ rocks = { "luautf8" } })
	end,
}
