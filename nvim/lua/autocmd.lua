-- Highlight text on yank
require("utils").create_augroup(
    { { "TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()" } },
    "_highlight_on_yank"
)

require("utils").create_augroup(
    { { "FileType", "dashboard", "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2" } },
    "_dashboard"
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
    { "FileType", "json", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "javascript", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "javascriptreact", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "lua", "setlocal", "shiftwidth=4 softtabstop=4 tabstop=4" },
    {
        "FileType",
        "python",
        "setlocal",
        "shiftwidth=4 softtabstop=4 tabstop=4 indentkeys-=<:> indentkeys-=:",
    },
    { "FileType", "typescript", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "typescriptreact", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "vue", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "yaml", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "bash", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
    { "FileType", "zsh", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2" },
}, "_filetype_indent")

require("utils").create_augroup({
    { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
}, "_buffer_bindings")

require("utils").create_augroup({
    { "FileType", "markdown", "setlocal wrap" },
    { "FileType", "markdown", "setlocal spell" },
}, "_markdown")

require("utils").create_augroup({
    { "BufWritePost", "plugins.lua", "source <afile> | PackerCompile" },
    { "User", "PackerComplete", "++once", "Restart" },
}, "_packer")

require("utils").create_augroup({
    { "FileType", "fugitive,gitcommit,help,markdown,packer", 'let &colorcolumn=""' },
}, "_no_colorcolumn")
