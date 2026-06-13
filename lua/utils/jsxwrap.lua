-- Expands a tag-wrap snippet around the text most recently stashed by
-- LuaSnip's cut_keys (see the <leader>w mapping in autocmds.lua).
-- The stashed selection is read back through env.LS_SELECT_DEDENT.
return function()
	local ls = require("luasnip")
	local fmt = require("luasnip.extras.fmt").fmt
	local rep = require("luasnip.extras").rep

	ls.snip_expand(ls.snippet("", fmt("<{}>\n\t{}\n</{}>", {
		ls.insert_node(1, "div"),
		ls.function_node(function(_, snip)
			return snip.env.LS_SELECT_DEDENT or {}
		end),
		rep(1),
	})))
end
