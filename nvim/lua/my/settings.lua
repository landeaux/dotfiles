local cmd = vim.cmd
local g = vim.g
local opt = vim.opt

vim.keymap.set({ "n", "v" }, "<Space>", "", { silent = true })
g.mapleader = " "

vim.keymap.set({ "n", "v" }, "\\", "", { silent = true })
g.maplocalleader = "\\"

cmd("filetype plugin on")

-- Determine the OS so we can use it in logic elsewhere by accessing vim.g.os
g.os = vim.fn.system("uname"):gsub("\n", "")

g.theme = "catppuccin"

g.soft_column_limit = 80
g.hard_column_limit = 120
opt.colorcolumn = ""

-- Misc
-- (NOTE: don't use opt.syntax = "enable" here. It will not work!)
cmd("syntax enable") -- enable syntax highlighting
opt.hidden = true -- allow for switching buffers without saving
opt.encoding = "utf-8"
opt.clipboard = { "unnamed", "unnamedplus" }
opt.backspace = { "eol", "start", "indent" }
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.autoread = true -- auto read file changes
opt.undofile = true -- persistent undo
opt.spelllang = "en"
opt.spellsuggest = { "best", "9" }
opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- Project specific vimrc with secure
opt.exrc = true
opt.secure = true

-- Indent
opt.autoindent = true
opt.smartindent = true

-- Tabs
local indent = 2
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
opt.laststatus = 2 + vim.fn.has("nvim-0.7") -- if 0.7, use single status line (3), else use (2)
opt.cmdheight = 0 -- hide the command line
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
    diff = "╱",
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

-- Performance
opt.updatetime = 0
opt.lazyredraw = true -- faster macros
opt.redrawtime = 1500
opt.ttimeoutlen = 10
opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("cI")

-- theme
opt.termguicolors = true
