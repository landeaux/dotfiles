-- Highlight text on yank
require("utils").create_augroup(
    { { "TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()" } },
    "_highlight_on_yank"
)

require("utils").create_augroup({
    { "BufWritePost", "plugins.lua", "source <afile> | PackerCompile" },
    -- { "User", "PackerComplete", "++once", "Restart" },
}, "_packer")
