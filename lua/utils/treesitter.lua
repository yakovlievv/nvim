local M = {}

function M.ensure_treesitter_cli(cb)
    cb = cb or function() end -- default to empty function

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

return M
