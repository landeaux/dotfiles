local create_augroup = require("my.utils").create_augroup

-- Highlight text on yank
create_augroup({
    {
        event = "TextYankPost",
        opts = { pattern = "*", command = "silent! lua vim.highlight.on_yank()" },
    },
}, "_highlight_on_yank")

create_augroup({
    {
        event = "BufWritePre",
        opts = { pattern = "*", command = ":%s/\\s\\+$//e" },
    },
}, "_trim_trailing_whitespace")

create_augroup({
    {
        event = "BufWritePost",
        opts = {
            pattern = "pluginsInit.lua",
            command = "source <afile> | PackerCompile",
        },
    },
}, "_packer")
