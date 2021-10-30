local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

local soft_column_limit = 80
local hard_column_limit = 120
local indent = 4

vim.o.termguicolors = true
g.mapleader = " "
g.maplocalleader = ","

-- Misc
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- Set encoding
opt.encoding = "utf-8"

-- Wildmenu
opt.wildmode = "longest,list,full"
opt.wildmenu = true

-- Hidden buffers to switch buffers without saving
opt.hidden = true

-- Enable mouse support
-- opt.mouse = "a"

-- Project specific vimrc with secure
opt.exrc = true
opt.secure = true

-- GUI cursor
opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor50",
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- Persistent undo
opt.undofile = true

-- Auto read file changes
opt.autoread = true

-- Backspace
opt.backspace = "indent,eol,start"

-- Make last window always have a status line
opt.laststatus = 2

-- Faster macros
opt.lazyredraw = true

-- Indent
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Spelling
opt.spellfile = vim.fn.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add"

-- Listchars
opt.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»"

-- Linebreak and wrap behavior
opt.linebreak = true
opt.breakindent = true

-- Show column limit indicators
-- cmd('let &colorcolumn = join(range(' .. tostring(fill_column) .. ',999), ",")')
cmd(
    'let &colorcolumn="'
        .. tostring(soft_column_limit)
        .. ',".join(range('
        .. tostring(hard_column_limit)
        .. ',999),",")'
)

-- Line numbers: Hybrid
opt.number = true
opt.relativenumber = true

-- Folding (with Treesitter)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Incremental command
opt.inccommand = "nosplit"

-- Completion
opt.completeopt = "menu,menuone,preview,noselect"
opt.completeopt = "menuone,noselect"
opt.shortmess = opt.shortmess + { c = true }

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Faster update time
opt.updatetime = 0
opt.signcolumn = "yes"

-- Highlight current line
opt.cursorline = true

-- Scroll offsets
opt.scrolloff = 0
opt.sidescrolloff = 5

-- Enable filetype plugin
cmd("filetype plugin on")

-- Enable syntax highlighting
cmd("syntax enable")

-- Enable clipboard
opt.clipboard = "unnamed,unnamedplus"

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
