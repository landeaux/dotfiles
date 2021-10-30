local create_augroup = require("my.utils").create_augroup

-- Highlight text on yank
create_augroup(
    { { "TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()" } },
    "_highlight_on_yank"
)

create_augroup({
    { "BufWritePre", "*", ":%s/\\s\\+$//e" },
}, "_trim_trailing_whitespace")

create_augroup({
    { "BufWritePost", "pluginsInit.lua", "source <afile> | PackerCompile" },
}, "_packer")
