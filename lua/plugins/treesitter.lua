return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    version = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    event = { "VeryLazy" },
    config = function()
        local ts = require("nvim-treesitter")
        local utils = require("utils.treesitter")
        local installed = ts.get_installed()
        local available_parsers = ts.get_available()
        local ensure_installed = {
            "bash",
            "zsh",
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

        -- Check treesitter cli
        utils.ensure_treesitter_cli()

        -- Install missing parsers from ensure installed
        local not_installed = vim.tbl_filter(function(parser)
            return not vim.tbl_contains(installed, parser)
        end, ensure_installed)
        if #not_installed > 0 then
            ts.install(not_installed, { summary = true })
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            group = vim.api.nvim_create_augroup("my.treesitter", { clear = true }),

            callback = function(event)
                local lang = vim.treesitter.language.get_lang(event.match)
                if not lang then
                    return
                end

                -- Try installing parser for current buffer if missing
                if not vim.treesitter.language.add(lang) then
                    local is_available = vim.tbl_contains(available_parsers, lang)
                    if is_available then
                        ts.install(lang)
                        vim.notify("Installing parser. Wait, then restart Neovim.")
                    end

                    -- Try enabling capabilities
                else
                    if not pcall(vim.treesitter.start, event.buf, lang) then
                        vim.notify("Treesitter fucked up!" .. lang, vim.log.levels.INFO)
                        return
                    end
                    vim.defer_fn(function()
                        vim.wo.foldmethod = "expr"
                        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        vim.wo.foldtext = "v:lua.require'utils.fold'.fold_text()"
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end, 50) -- 50ms delay
                end
            end,
        })
    end,
}
