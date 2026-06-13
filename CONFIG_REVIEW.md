# Neovim Config Review

A full assessment of the config in `/Users/yako/dotfiles/nvim`.

- **Neovim:** 0.12.0-dev (Homebrew)
- **Plugins:** 62 (lazy.nvim)
- **Reviewer:** static read of every file in `lua/` + lock file. Performance numbers are architectural estimates — see [Performance](#performance) for the two commands that turn them into hard numbers.

## TL;DR scorecard

| Area | Grade | One-line verdict |
|---|---|---|
| Workflow | **A** | Coherent, modern, opinionated. oil + harpoon + snacks.picker is a fast triad. |
| Performance | **A-** | Near-textbook lazy-loading. One eager load (snacks) is justified; a couple of aggressive timings. |
| Keybindings | **B+** | Excellent breadth and consistency, but a real `<leader>c` collision and an insert-mode `<C-k>` ambiguity. |
| Plugin set | **A-** | Well-curated, current APIs, minimal dead weight. One redundancy (oil + neo-tree) and two notable gaps (DAP, tests). |
| Options / autocmds | **A** | Thoughtful, well-commented, modern. The view/fold autocmd is genuinely well-engineered. |

**Overall: A-.** This is a senior-level config. It uses current APIs throughout (`vim.lsp.config`, treesitter `main` branch, blink.cmp, snacks), avoids deprecated patterns, and the comments show you understand *why* each non-obvious choice was made. The issues below are polish, not foundation.

---

## Workflow — A

The core loop is tight and consistent:

- **File navigation:** `oil.nvim` as the default explorer (buffer-as-directory editing) + `yazi` for a TUI view + `neo-tree` for a sidebar tree. `<C-e>` toggles oil, `<leader>e` reveals neo-tree.
- **Project jumping:** `harpoon2` on `<C-1>`–`<C-8>` for pinned files, `snacks.picker.smart()` on `<C-f>` for fuzzy find. This is the right two-tier model: pinned for the 4–8 files you live in, fuzzy for everything else.
- **Search/replace:** `<leader>/` grep, `grug-far` for structured replace, `<leader>S` for word-under-cursor substitute. Good coverage.
- **Git:** lazygit (`<leader>gg`), gitsigns hunks (`]h`/`[h`, stage/reset), diffview, git-conflict, and snacks pickers for branches/log/status/stash + GitHub issues/PRs. This is a complete git surface without leaving Neovim.
- **AI:** supermaven (inline ghost-text completion) + claudecode.nvim (agentic). These are complementary, not redundant — one autocompletes, one refactors.

**The `<Tab>` accept chain is the standout detail** (`supermaven.lua:20`): `<Tab>` accepts an AI suggestion if one is showing, else falls through to `tabout.nvim`, else inserts a tab. That's exactly the disambiguation most configs get wrong.

**Friction points:**
- **oil + neo-tree overlap.** Two file explorers is one more than most workflows need. It's defensible (oil for editing operations, neo-tree for a persistent tree + git status column), but if you find yourself only ever using one, dropping the other removes ~313 lines and a plenary/nui dependency chain. Not a bug — a decision worth revisiting.
- The `<C-d>`/`<C-u>` → `…zz` recenter remaps (`keymaps.lua:145`) are nice, but combined with `smoothscroll` the forced `zz` can feel like a double-jump. Minor taste call.

---

## Performance — A-

The lazy-loading architecture is close to textbook:

- Almost everything loads on `event` / `cmd` / `keys` / `ft`. LSP, lint, gitsigns on file-open events; conform on `BufWritePre` only; blink on `InsertEnter`/`CmdlineEnter`; treesitter + context + textobjects on `VeryLazy`.
- The custom `LazyFile` event (`lazy-init.lua:21`) is the LazyVim trick to let the buffer paint *before* the file-plugin cascade fires. Good.
- Built-in providers (perl/python/ruby) and rtp plugins (gzip, matchit, tarPlugin, etc.) are disabled. `change_detection` and `checker` off. Clean.
- `bigfile` + `quickfile` from snacks handle large-file degradation.

**Things that cost startup or could be tuned:**
- **snacks loads eagerly** (`lazy = false, priority = 1000`). This is correct — it owns the dashboard, statuscolumn, and `vim.ui` — but it's your single biggest startup item. It also enables `animate`, `scroll` (disabled), `image`, `indent`, `words`, `scratch`, etc. all at once. If startup ever feels slow, `animate` and `words` are the first things to profile.
- **`blink` documentation `auto_show_delay_ms = 10`** (`blink.lua:70`). 10ms is essentially instant — on a large LSP response this can cause doc-window flicker as you arrow through items. 100–200ms is the usual comfort zone.
- **`updatetime = 150`** (`options.lua:70`) is aggressive (default 4000). Fine on a fast machine; it drives `CursorHold` (which also triggers your `checktime` autocmd) frequently. Worth knowing if battery/CPU ever matters.
- **`nvim-lint` runs on `BufEnter`** (`lint.lua:13`) in addition to write/InsertLeave. `BufEnter` fires often; only shellcheck is wired up so the cost is tiny today, but if you add linters, narrow this.

**To replace my estimates with real numbers, run these and paste me the output:**

```vim
:Lazy profile
```
```sh
nvim --startuptime /tmp/st.log +q && tail -40 /tmp/st.log
```

And inside a session, your own profiler is already bound: `<leader>Dpp` (`toggles.lua:38`) toggles `Snacks.profiler`. I can read either and give you exact hotspots.

---

## Keybindings — B+

Breadth and consistency are excellent: a clean `map()` wrapper, logical `<leader>` namespaces (`f`=files, `s`=search, `g`=git, `c`=code, `u`=ui toggles, `h`=hunks/harpoon, `a`=AI), which-key for discoverability, and good motion polish (`gj`/`gk` for `j`/`k`, search-centering `n`/`N`, jumplist-aware diagnostics). The LSP keymaps attach per-buffer in `LspAttach` (the correct pattern), and the `goto_definition` that picks "jump directly vs. open picker" based on result count (`keys/lsp.lua:1`) is a genuinely nice touch.

**Two real problems:**

1. **`<leader>c` collides with the entire `<leader>c…` code group.** `keymaps.lua:52` maps `<leader>c` directly to `[["_C]]`, and line 51 maps `<leader>C` to the *same* `[["_C]]`. So:
   - `<leader>c` and `<leader>C` are duplicates (line 52 is almost certainly meant to be `[["_c]]`).
   - Because `<leader>c` is a *complete* mapping, every `<leader>c…` code action (`cd`, `ca`, `ch`, `cl`, `cM`, `cD` from `autocmds.lua` + `keys/lsp.lua`) now has to wait out `timeoutlen` (400ms) before firing, and `<leader>c` alone will fire a no-yank change-to-EOL. This is the one binding I'd fix today: either remove the `<leader>c` map or move no-yank change to a non-prefix key.

2. **Insert-mode `<C-k>` is ambiguous.** `keymaps.lua:112` maps insert `<C-k>` to `vim.lsp.buf.hover`, while `blink.lua:41` maps `<C-k>` to `select_prev`. When the completion menu is open, blink wins (so hover is unreachable); when it's closed, you get hover. Pick one — most people want `<C-k>`/`<C-j>` as menu navigation and put hover elsewhere.

**Smaller notes:**
- `<C-q>` is described "Quit all" but runs `:q` (single window) (`keymaps.lua:136`).
- `<C-b>` is overloaded (alt-buffer in normal/insert; scroll-docs in blink) but the modes/fallbacks keep them from actually clashing.
- `Q` → `@q` (replay macro q) shadows Ex mode — intentional and good.

---

## Plugin set — A-

Curation is strong and current. No abandonware, no deprecated forks, versions pinned sensibly. Highlights:

- **LSP:** `vim.lsp.config` (0.11+ API, not the old `lspconfig` setup calls), SchemaStore for json/yaml, ruff+basedpyright split with hover ownership handed to basedpyright, vtsls with inlay hints and `completeFunctionCalls`. This is a properly tuned LSP layer, not a copy-paste.
- **Completion:** blink.cmp v1 built from Cargo source — fastest current option.
- **Treesitter:** `main` branch with the new manual-install + FileType-driven enable pattern, with per-language indent opt-outs where Neovim's built-in is better. Most configs are still on the old `master` API; you're not.
- **Folding:** nvim-ufo with a hand-written `lsp → treesitter → indent` provider chain that correctly catches `UfoFallbackException` (`ufo.lua:39`). This is the kind of thing people copy wrong; yours is right.
- **Editing:** mini.ai/surround, treesj, dial, yanky, spider, tabout, autopairs, ts-comments, matchup — a complete text-manipulation kit with no overlap.

**Gaps worth considering:**
- **No DAP.** lualine already has a guarded DAP status component (`lualine.lua:84`) and `autocmds.lua` whitelists `neotest-*` filetypes for `q`-to-close — so the *intent* is there but neither `nvim-dap` nor `neotest` is installed. If you debug or test in-editor, this is the biggest functional gap. If you don't, delete the dead component/whitelist entries to reduce confusion.
- **No test runner** (`neotest`), per above.
- **No structured notes/markdown-editing beyond render-markdown** — fine if you don't need it.
- `luarocks.nvim` is pulled in but only `vhyrro/luarocks.nvim` — confirm something actually needs it (rocks are disabled in lazy config), else it's a removable dependency.

Nothing here is bloated. The set is large because your workflow is broad, not because it's accreted junk.

---

## Options & autocmds — A

`options.lua` is modern and well-reasoned: global statusline (`laststatus=3`), `splitkeep=cursor`, `inccommand=split`, `smoothscroll`, `virtualedit=block`, persistent undo in `stdpath("state")`, `confirm=true`, smartcase search, system clipboard. The diagnostic config and `vim.filetype.add` for docker/helm/gitlab/mdx are nice quality-of-life.

**Autocmds are the best-engineered part of the config:**
- The **view/fold persistence** (`autocmds.lua:172`) is genuinely well-done: `viewoptions = "cursor,folds"` only (no curdir/options, which avoids the classic cwd-clobber bug), `loadview` guarded by a buffer-local flag so it fires *once* per load instead of snapping the cursor back on every window re-entry, and synchronous (no `vim.schedule`). The comment explaining the old jumping bug is exactly the documentation future-you needs.
- **Per-filetype indent groups** (`autocmds.lua:21`) match what prettier/stylua emit, so save doesn't produce fake diffs or cursor jumps. Smart.
- **macOS codesign re-signing** after lazy ops (`autocmds.lua:61`) — niche but correct fix for the `EXC_BAD_ACCESS` native-lib crash on Apple Silicon.
- Auto-create-parent-dirs on `:w`, auto-`checktime` on focus, `wincmd =` on resize, `q`-to-close for UI panels — all standard-but-correct.

**Tiny nits:**
- `linebreak = true` (`options.lua:27`) is a no-op while `wrap = false` (it only affects wrapped lines). Harmless, but your memory notes record it as "removed" — it's back. The markdown autocmd sets both locally anyway.
- The `close-with-q` filetype list (`autocmds.lua:148`) includes `neotest-*` panels for plugins you don't have installed yet. Cosmetic.

---

## Prioritized recommendations

**Fix now (5 minutes):**
1. `keymaps.lua:52` — `<leader>c` shouldn't be a standalone map; it duplicates `<leader>C` and stalls the whole `<leader>c…` LSP group behind `timeoutlen`. Change to `"_c` on a non-prefix key, or drop it.
2. Resolve the insert-mode `<C-k>` hover-vs-completion ambiguity (`keymaps.lua:112` vs `blink.lua:41`).

**Consider (worth a think):**
3. Decide whether you actually use both oil *and* neo-tree; drop one if not.
4. Either install `nvim-dap`(+`neotest`) to match the lualine/autocmd hooks, or remove the dead DAP/neotest references.
5. Bump `blink` doc `auto_show_delay_ms` from 10 to ~150 if you ever see doc-window flicker.

**Optional polish:**
6. Fix the `<C-q>` "Quit all" description (it's single-window).
7. Re-remove the no-op `linebreak = true` if you care about the memory note staying accurate.

**Verify performance empirically:** run the two commands in the [Performance](#performance) section (or toggle `<leader>Dpp`) and I'll turn the A- estimate into measured hotspots.
