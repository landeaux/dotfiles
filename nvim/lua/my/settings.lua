local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

local soft_column_limit = 80
local hard_column_limit = 120
local indent = 4

g.mapleader = " "
g.maplocalleader = ","

-- Misc
opt.syntax = "enable" -- enable syntax highlighting
opt.hidden = true -- allow for switching buffers without saving
opt.encoding = "utf-8"
opt.clipboard = { "unnamed", "unnamedplus" }
opt.backspace = { "eol", "start", "indent" }
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- Indent
opt.autoindent = true
opt.smartindent = true

-- Tabs
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.expandtab = true

-- Wildmenu
opt.wildmode = { "longest", "list", "full" }
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true -- highlight current line
opt.signcolumn = "yes"
opt.laststatus = 2 -- make last window always have a status line

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

-- Faster macros
opt.lazyredraw = true

-- Spelling
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Listchars
opt.listchars = {
    eol = "¬",
    extends = "»",
    lead = "·",
    nbsp = "␣",
    precedes = "«",
    space = "·",
    tab = "|→",
    trail = "•",
}

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

-- Incremental command
opt.inccommand = "nosplit"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-- Split options
opt.splitbelow = true
opt.splitright = true

-- Faster update time
opt.updatetime = 0

-- Scroll offsets
opt.scrolloff = 0
opt.sidescrolloff = 5

-- Enable filetype plugin
cmd("filetype plugin on")

-- Enable syntax highlighting
cmd("syntax enable")

-- theme
opt.termguicolors = true

-- Determine the OS so we can use it in logic elsewhere by accessing vim.g.os
vim.g.os = vim.fn.system("uname"):gsub("\n", "")
