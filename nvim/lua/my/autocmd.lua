local utils = require("my.utils")

-- Highlight text on yank
utils.create_augroup({
    {
        event = "TextYankPost",
        opts = {
            pattern = "*",
            callback = function() vim.hl.on_yank() end,
        },
    },
}, "_highlight_on_yank")

utils.create_augroup({
    {
        event = "FileType",
        opts = {
            pattern = "markdown",
            callback = function() utils.set_buffer_soft_line_nagivation() end,
        },
    },
}, "_markdown_nav")

utils.create_augroup({
    -- clear any mappings on <CR> (e.g. Treesitter incremental selection)
    {
        event = "CmdWinEnter",
        opts = {
            callback = function() vim.keymap.del("n", "<CR>", { buffer = true }) end,
        },
    },
}, "_cmd_win")

utils.create_augroup({
    {
        event = "VimResized",
        opts = {
            callback = function()
                local current_tab = vim.fn.tabpagenr()
                vim.cmd("tabdo wincmd =")
                vim.cmd("tabnext " .. current_tab)
            end,
        },
    },
}, "_resize_splits")

utils.create_augroup({
    {
        event = "BufEnter",
        opts = {
            callback = function()
                if vim.bo.buftype ~= "" then
                    return
                end
                local root = vim.fs.root(0, {
                    { ".git", ".hg", ".svn" },
                    { "package.json", "pyproject.toml", "Cargo.toml", "go.mod" },
                })
                if root then
                    vim.cmd.cd(root)
                end
            end,
        },
    },
}, "_cd_project_root")
