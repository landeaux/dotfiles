local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

local soft_column_limit = 80
local hard_column_limit = 120
local indent = 2

cmd([[
	filetype plugin indent on
	autocmd BufWritePre * :%s/\s\+$//e
]])

g.mapleader = " "
g.maplocalleader = ","

-- Misc
opt.syntax = "enable"
opt.hidden = true
opt.encoding = "utf-8"
-- opt.clipboard = "unnamed,unnamedplus"
opt.clipboard = "unnamedplus"
opt.backspace = { "eol", "start", "indent" }
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- Indentation
opt.autoindent = true
opt.smartindent = true

-- Tabs
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true

-- Search
opt.wildmenu = true
opt.wildmode = "longest,list,full"
opt.wildignore = opt.wildignore
    + { "*/node_modules/*", "*/wp-includes/*", "*/wp-admin/*", "*/vendor/*" }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "nosplit"

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.laststatus = 2
opt.scrolloff = 0
opt.sidescrolloff = 5
opt.listchars = {
    eol = "¬",
    extends = "»",
    lead = "·",
    nbsp = "␣",
    precedes = "«",
    tab = "❘-",
    -- tab = "→\\ ",
    trail = "•",
}
opt.showmode = false
opt.lazyredraw = true
opt.splitright = true
opt.splitbelow = true
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,"
    .. "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,"
    .. "sm:block-blinkwait175-blinkoff150-blinkon175"
cmd(
    'let &colorcolumn="'
        .. tostring(soft_column_limit)
        .. ',".join(range('
        .. tostring(hard_column_limit)
        .. ',999),",")'
)
opt.linebreak = true
opt.breakindent = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.termguicolors = true

-- Backups
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Persistent undo
opt.undofile = true

-- Auto read file changes
opt.autoread = true

-- Completion
-- opt.completeopt = "menu,menuone,preview,noselect"
-- opt.completeopt = "menuone,noselect"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

-- Performance
opt.updatetime = 0
-- opt.updatetime = 100
opt.timeoutlen = 400
opt.redrawtime = 1500
opt.ttimeoutlen = 10

-- Project specific vimrc with secure
opt.exrc = true
opt.secure = true

-- Spelling
opt.spellfile = vim.fn.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add"

-- Determine the OS so we can use it in logic elsewhere by accessing vim.g.os
cmd([[
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif
]])
