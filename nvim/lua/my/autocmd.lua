local utils = require("my.utils")

-- Highlight text on yank
utils.create_augroup({
    {
        event = "TextYankPost",
        opts = {
            pattern = "*",
            callback = function()
                vim.highlight.on_yank()
            end,
        },
    },
}, "_highlight_on_yank")

-- TODO: move this to null-ls
utils.create_augroup({
    {
        event = "BufWritePre",
        opts = { pattern = "*", command = ":%s/\\s\\+$//e" },
    },
}, "_trim_trailing_whitespace")

utils.create_augroup({
    {
        event = "FileType",
        opts = {
            pattern = "markdown",
            callback = function()
                utils.set_buffer_soft_line_nagivation()
            end,
        },
    },
}, "_markdown_nav")
