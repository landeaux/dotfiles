-- Highlight text on yank
require("utils").create_augroup(
    { { "TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()" } },
    "_highlight_on_yank"
)

require("utils").create_augroup({
    { "BufRead,BufNewFile", "*.graphql,*.graphqls,*.gql", "set filetype=graphql" },
    { "BufRead,BufNewFile", ".env.*", "set filetype=sh" },
    { "BufRead,BufNewFile", ".gitconfig.local", "set filetype=gitconfig" },
    { "BufRead,BufNewFile", ".pylintrc", "set filetype=conf" },
    { "BufRead,BufNewFile", ".tmux.conf.local", "set filetype=tmux" },
    { "BufRead,BufNewFile", ".zshrc.local", "set filetype=zsh" },
    { "BufRead,BufNewFile", "Dockerfile-*", "set filetype=dockerfile" },
    { "BufRead,BufNewFile", "Dockerfile.*", "set filetype=dockerfile" },
    { "BufRead,BufNewFile", "gitconfig", "set filetype=gitconfig" },
    { "BufRead,BufNewFile", "gitignore", "set filetype=conf" },
    { "BufRead,BufNewFile", "zprofile", "set filetype=zsh" },
}, "_filetype_detect")

require("utils").create_augroup({
    { "BufWritePost", "plugins.lua", "source <afile> | PackerCompile" },
    { "User", "PackerComplete", "++once", "Restart" },
}, "_packer")
