local cmd = vim.cmd
local set_opt = require("utils").set_opt
local append_opt = require("utils").append_opt

local fill_column = 80
local indent = 4

-- Set encoding
set_opt("o", "encoding", "utf-8")

-- Wildmenu
set_opt("o", "wildmode", "longest,list,full")
set_opt("o", "wildmenu", true)

-- Hidden buffers to switch buffers without saving
set_opt("o", "hidden", true)

-- Enable mouse support
set_opt("o", "mouse", "a")

-- Project specific vimrc with secure
set_opt("o", "exrc", true)
set_opt("o", "secure", true)

-- GUI cursor
set_opt("o", "guicursor", "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50," ..
            "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor," ..
            "sm:block-blinkwait175-blinkoff150-blinkon175")

-- Persistent undo
set_opt("o", "undofile", true)

-- Auto read file changes
set_opt("o", "autoread", true)

-- Backspace
set_opt("o", "backspace", "indent,eol,start")

-- Make last window always have a status line
set_opt("o", "laststatus", 2)

-- Indent
set_opt("b", "tabstop", indent)
set_opt("b", "softtabstop", indent)
set_opt("b", "shiftwidth", indent)
set_opt("b", "expandtab", true)
set_opt("b", "autoindent", true)
set_opt("b", "smartindent", true)

-- Listchars
set_opt("w", "listchars", "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»")

-- Linebreak and wrap behavior
set_opt("w", "linebreak", true)
set_opt("w", "breakindent", true)

-- Show fill column indicator
cmd("let &colorcolumn = join(range(" .. tostring(fill_column) .. ",999), \",\")")

-- Line numbers: Hybrid
set_opt("w", "number", true)
set_opt("w", "relativenumber", true)

-- Folding (with Treesitter)
set_opt("w", "foldmethod", "expr")
set_opt("w", "foldexpr", "nvim_treesitter#foldexpr()")
set_opt("w", "foldlevel", 99)

-- Search
set_opt("o", "hlsearch", true)
set_opt("o", "incsearch", true)
set_opt("o", "ignorecase", true)
set_opt("o", "smartcase", true)
set_opt("o", "gdefault", true)

-- Incremental command
set_opt("o", "inccommand", "nosplit")

-- Completion
set_opt("o", "completeopt", "menuone,preview,noselect")
append_opt("o", "shortmess", "c")

-- Split options
set_opt("o", "splitbelow", true)
set_opt("o", "splitright", true)

-- Faster update time
set_opt("o", "updatetime", 100)
set_opt("o", "signcolumn", "yes")

-- Wait less time for a mapped sequence to complete
set_opt("o", "timeoutlen", 300)

-- Highlight current line
set_opt("o", "cursorline", true)

-- Scroll offsets
set_opt("o", "scrolloff", 0)
set_opt("o", "sidescrolloff", 5)

-- Enable filetype plugin
cmd "filetype plugin on"

-- Highlight text on yank
require("utils").create_augroup({{"TextYankPost", "*", "silent!", "lua vim.highlight.on_yank()"}},
                                "highlight_on_yank")

require("utils").create_augroup({
    {"BufRead,BufNewFile", ".env.*", "set filetype=sh"},
    {"BufRead,BufNewFile", ".gitconfig.local", "set filetype=gitconfig"},
    {"BufRead,BufNewFile", ".pylintrc", "set filetype=conf"},
    {"BufRead,BufNewFile", ".tmux.conf.local", "set filetype=tmux"},
    {"BufRead,BufNewFile", ".zshrc.local", "set filetype=sh"},
    {"BufRead,BufNewFile", "Dockerfile.*", "set filetype=dockerfile"},
    {"BufRead,BufNewFile", "Dockerfile-*", "set filetype=dockerfile"},
    {"BufRead,BufNewFile", "gitconfig", "set filetype=gitconfig"},
    {"BufRead,BufNewFile", "gitignore", "set filetype=conf"},
    {"BufRead,BufNewFile", "*.graphql,*.graphqls,*.gql", "set filetype=graphql"}
}, "custom_filetypedetect")

-- autocmd FileType python setlocal indentkeys-=:
require("utils").create_augroup({
    {"FileType", "javascript", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"},
    {"FileType", "javascriptreact", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"},
    {"FileType", "lua", "setlocal", "shiftwidth=4 softtabstop=4 tabstop=4"},
    {"FileType", "python", "setlocal", "shiftwidth=4 softtabstop=4 tabstop=4"},
    {"FileType", "typescript", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"},
    {"FileType", "typescriptreact", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"},
    {"FileType", "vue", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"},
    {"FileType", "yaml", "setlocal", "shiftwidth=2 softtabstop=2 tabstop=2"}
}, "filetype_indent")

-- Enable syntax highlighting
cmd "syntax enable"

-- Enable clipboard
set_opt("o", "clipboard", "unnamed,unnamedplus")
