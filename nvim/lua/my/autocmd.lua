local create_augroup = require("my.utils").create_augroup

-- Highlight text on yank
create_augroup({
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

create_augroup({
    {
        event = "BufWritePre",
        opts = { pattern = "*", command = ":%s/\\s\\+$//e" },
    },
}, "_trim_trailing_whitespace")
