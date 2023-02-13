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
