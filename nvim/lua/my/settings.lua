local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

local soft_column_limit = 80
local hard_column_limit = 120
local indent = 2

g.mapleader = " "
g.maplocalleader = ","

cmd("filetype plugin on")

-- Determine the OS so we can use it in logic elsewhere by accessing vim.g.os
vim.g.os = vim.fn.system("uname"):gsub("\n", "")

-- Misc
-- (NOTE: don't use opt.synax = "enable" here. It will not work!)
cmd("syntax enable") -- enable syntax highlighting
opt.hidden = true -- allow for switching buffers without saving
opt.encoding = "utf-8"
opt.clipboard = { "unnamed", "unnamedplus" }
opt.backspace = { "eol", "start", "indent" }
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.autoread = true -- auto read file changes
opt.undofile = true -- persistent undo
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Project specific vimrc with secure
opt.exrc = true
opt.secure = true

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

-- Incremental command
opt.inccommand = "split"

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true -- highlight current line
opt.signcolumn = "yes"
opt.laststatus = 2 -- make last window always have a status line
opt.wrap = true
opt.linebreak = true
opt.breakindent = true -- indent wrapped lines
opt.scrolloff = 0
opt.sidescrolloff = 5
opt.list = false
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
opt.fillchars = {
    diff = " ",
    eob = " ",
}
opt.showmode = false
-- opt.mouse = "a"
opt.splitbelow = true
opt.splitright = true
opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:ver25",
    "r-cr:hor20",
    "o:hor50",
    "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
    "sm:block-blinkwait175-blinkoff150-blinkon175",
}
cmd(
    'let &colorcolumn="'
        .. tostring(soft_column_limit)
        .. ',".join(range('
        .. tostring(hard_column_limit)
        .. ',999),",")'
) -- show column limit indicators

-- Performance
opt.updatetime = 0
opt.lazyredraw = true -- faster macros
opt.redrawtime = 1500
opt.ttimeoutlen = 10

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("cI")

-- theme
opt.termguicolors = true
