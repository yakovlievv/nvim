local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- text staged via store_selection_keys (<Tab> in visual mode), dedented
local function selected(_, snip)
	return snip.env.LS_SELECT_DEDENT or {}
end

return {
	-- wrap a JSX *element* in a tag -- no { } expression braces
	s(
		"jsxw",
		fmt(
			[[
<{}>
	{}
</{}>]],
			{
				i(1, "div"),
				f(selected),
				rep(1),
			}
		)
	),

	-- wrap a JS expression / string in a tag -- WITH { } braces
	s(
		"jsxwb",
		fmt(
			[[
<{}>
	{{{}}}
</{}>]],
			{
				i(1, "div"),
				f(selected),
				rep(1),
			}
		)
	),
}
