-- PROTOTYPE window layout via edgy.nvim.
-- Self-contained: delete/comment this ONE file to fully disable the layout.
-- (The only touch outside this file is `open_files_do_not_replace_types` in
--  neotree.lua, which is harmless on its own — see the summary I gave you.)
--
-- Edges:
--   right  -> claudecode.nvim terminal
--   left   -> neo-tree (filesystem, pinned) + Trouble symbols + grug-far + undotree
--   bottom -> Trouble diagnostics + the <leader>t split terminal
--
-- IMPORTANT: edgy only RELOCATES windows that your existing keymaps already
-- create. It adds no keymaps of its own, so <leader>t, <C-t>, <leader>ac,
-- the Trouble binds, etc. all keep working exactly as before.

-- ---------------------------------------------------------------------------
-- Discriminators (verified from plugin source, see chat summary)
-- ---------------------------------------------------------------------------

-- A floating window has a non-empty `relative`; a real split has relative == "".
-- This is how we keep the <C-t> FLOATING terminal out of every edge.
local function is_float(win)
	return vim.api.nvim_win_get_config(win).relative ~= ""
end

-- All three terminals (<C-t> float, <leader>t split, claudecode) share the
-- filetype "snacks_terminal", so filetype alone cannot tell them apart.
-- claudecode runs the `claude` command, so its buffer name contains "claude";
-- the <leader>t terminal runs your shell, so it does not. This is the only
-- stable distinguisher between the two split terminals without changing your
-- terminal config.
local function is_claude(buf)
	return vim.api.nvim_buf_get_name(buf):lower():find("claude", 1, true) ~= nil
end

return {
	-- =====================================================================
	-- 1) edgy.nvim itself
	-- =====================================================================
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			-- edgy only collapses views fully with a GLOBAL statusline. You
			-- already set laststatus=3 in options.lua, so this is just a guard
			-- in case that ever changes.
			vim.opt.laststatus = 3
			-- "screen" keeps text put when edgebars open/close (less jump than
			-- your default "cursor"). Reverts to "cursor" automatically if you
			-- delete this file, since this init() simply won't run.
			vim.opt.splitkeep = "screen"
			-- undotree normally opens TWO windows (the tree + a diff preview).
			-- A narrow left edgebar is a poor place for a diff, so we suppress
			-- the auto diff and dock only the tree. You can still open the diff
			-- manually inside undotree. Set back to 1 (default) if you'd rather
			-- dock both. Lives here so deleting this file restores default.
			vim.g.undotree_DiffAutoOpen = 0
		end,
		opts = {
			-- Prototype: no animation, snappier and easier to reason about.
			animate = { enabled = false },

			-- Per-edge sizing. edgebar windows CANNOT be resized interactively
			-- like normal splits, so these values are the source of truth.
			options = {
				left = { size = 40 }, -- columns
				bottom = { size = 15 }, -- lines
				right = { size = 60 }, -- columns (claude needs room)
			},

			-- -------------------------------------------------------------
			-- LEFT edge
			-- -------------------------------------------------------------
			left = {
				-- Neo-tree filesystem: the ONLY pinned left view. Pinning all
				-- four would cram the edge; the rest are ephemeral (they show
				-- only when you invoke them and vanish when closed).
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					-- neo-tree sets b:neo_tree_source per source; we want only
					-- the filesystem tree here (not git_status / buffers).
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "filesystem"
					end,
					pinned = true,
					open = "Neotree position=left filesystem",
					-- NO fixed `size`: a view with a size becomes "fixed" and won't
					-- yield space, which is what made the edge cram. Leaving it unset
					-- makes it auto-sized, so it shares the column and grows to fill
					-- whenever you fold a sibling with <c-g>.
				},
				-- Neo-Tree git status (same ft, different source) -> left edge.
				{
					title = "Git",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "git_status"
					end,
					open = "Neotree position=left git_status",
				},
				-- Neo-Tree open buffers (same ft, different source) -> left edge.
				{
					title = "Buffers",
					ft = "neo-tree",
					filter = function(buf)
						return vim.b[buf].neo_tree_source == "buffers"
					end,
					open = "Neotree position=left buffers",
				},
				-- Trouble "symbols" view = document outline. Ephemeral.
				{
					title = "Symbols",
					ft = "trouble",
					-- Trouble v3 stamps each window with w:trouble; the symbols
					-- outline is the one whose mode == "symbols".
					filter = function(_, win)
						return vim.w[win].trouble and vim.w[win].trouble.mode == "symbols"
					end,
					open = "Trouble symbols toggle focus=false",
				},
				-- undotree (tree window only; diff suppressed via init above).
				{
					title = "Undotree",
					ft = "undotree",
					open = "UndotreeToggle",
				},
			},

			-- -------------------------------------------------------------
			-- BOTTOM edge
			-- -------------------------------------------------------------
			bottom = {
				-- Trouble diagnostics: every Trouble view EXCEPT symbols lands
				-- here (diagnostics, qflist, loclist, lsp refs, ...). Mode-based
				-- so it never steals the symbols outline from the left edge.
				{
					title = "Diagnostics",
					ft = "trouble",
					filter = function(_, win)
						return vim.w[win].trouble and vim.w[win].trouble.mode ~= "symbols"
					end,
					open = "Trouble diagnostics toggle",
				},
				-- Quickfix list (enhanced by quicker.nvim). ft "qf" covers both
				-- quickfix and location lists; for this prototype we dock either.
				{
					title = "Quickfix",
					ft = "qf",
					open = function()
						require("quicker").toggle()
					end,
				},
				-- <leader>t split terminal. It's a snacks_terminal that is (a)
				-- not a float and (b) not the claude terminal -> this one.
				{
					title = "Terminal",
					ft = "snacks_terminal",
					filter = function(buf, win)
						return not is_float(win) and not is_claude(buf)
					end,
					-- mirrors your <leader>t (Snacks default position = bottom).
					open = function()
						Snacks.terminal.toggle()
					end,
					-- no fixed size: shares the bottom edge with Diagnostics and
					-- grows when you fold the other with <A-q>.
				},
			},

			-- -------------------------------------------------------------
			-- RIGHT edge
			-- -------------------------------------------------------------
			right = {
				-- claudecode terminal: snacks_terminal, a real split, whose
				-- bufname contains "claude". Ephemeral (toggled by <leader>ac).
				{
					title = "Claude Code",
					ft = "snacks_terminal",
					filter = function(buf, win)
						return not is_float(win) and is_claude(buf)
					end,
					open = "ClaudeCode",
					-- width comes from options.right.size (60).
				},
				-- grug-far search & replace. Ephemeral. Distinguished by ft.
				{
					title = "Search/Replace",
					ft = "grug-far",
					-- grug-far can open multiple instances; only dock the real
					-- split, never an (unlikely) floating preview.
					filter = function(_, win)
						return not is_float(win)
					end,
					open = "GrugFar",
				},
			},

			-- Buffer-local keymaps INSIDE edgebar windows only.
			keys = {
				-- You have <c-q> bound to quit globally. edgy maps <c-q> -> fold
				-- buffer-locally, which would shadow your quit inside edgebars.
				-- Disable it so your quit passes through here too.
				["<c-q>"] = false,
				-- Fold the current view down to its title bar (frees its space for
				-- the others). Re-expand by entering it (]w / [w) — edgy auto-shows
				-- the view you focus.
				["<c-g>"] = function(win)
					-- Keep the cursor in the edge: hop to a neighbouring OPEN
					-- section first (prev above, else next below), so acting on
					-- `win` below doesn't bounce us to the center editor. If no
					-- other section is open we fall through (cursor ends up in the
					-- center — there's nowhere else in the edge to go).
					local target = win:prev({ visible = true }) or win:next({ visible = true })
					if target then
						target:focus()
					end
					-- Vertical edges (left/right) fold cleanly to a 1-row title bar.
					-- Horizontal edges (bottom/top) can't: edgy keeps full height
					-- and just narrows the width, leaving squished content. So on
					-- those, CLOSE the section instead (reopen with its toggle:
					-- <leader>cx diagnostics, <leader>q quickfix, <leader>t term).
					if win.view.edgebar.vertical then
						win:hide()
					else
						win:close()
					end
				end,
				-- You use ]w / [w elsewhere; stop edgy from stealing them inside
				-- edgebars.
				["]w"] = false,
				["[w"] = false,
				["]W"] = false,
				["[W"] = false,
				-- Switch sections within the edge with <c-j> / <c-k>. Because these
				-- are buffer-local to edgebar windows, they only shadow your global
				-- move-text <c-j>/<c-k> WHILE you're inside an edge — normal buffers
				-- still move text. `focus` (no visible filter) cycles through every
				-- section including folded ones, and landing on a folded view
				-- auto-expands it.
				["<c-j>"] = function(win)
					win:next({ focus = true })
				end,
				["<c-k>"] = function(win)
					win:prev({ focus = true })
				end,
			},

			-- Don't let leftover edgebar windows trap you in nvim: if only edgy
			-- windows remain, allow quitting.
			-- NOTE: edgy implements this with an unforced `qa` fired from a
			-- nested WinClosed autocmd (edgy/editor.lua:45). With any unsaved
			-- buffer that errors `E37: No write since last change`, and because
			-- transient floats (blink.cmp menu, nui popups) also trip WinClosed
			-- during teardown, it spews a cascade of errors on quit. Left off.
			exit_when_last = false,
		},
	},

	-- =====================================================================
	-- 2) neo-tree opts merge (kept here so the layout stays one file)
	--    NOTE: your neotree.lua uses a hardcoded config=function() that calls
	--    setup() directly and ignores merged opts, so this spec alone is NOT
	--    enough — the real change is the one-line edit in neotree.lua. This
	--    block is left as documentation of intent / a no-op safety net.
	-- =====================================================================
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			-- Prevents "open file from tree" from hijacking an edgy-docked
			-- window (terminal/Trouble/qf/edgy).
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "edgy" },
		},
	},
}
