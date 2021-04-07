local utils = require('utils')

local cmd = vim.cmd
local indent = 2

cmd('syntax enable')
cmd('filetype plugin indent on')

utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 4)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('o', 'numberwidth', 2)
utils.opt('w', 'signcolumn', 'yes')
utils.opt('w', 'listchars', 'tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»')
utils.opt('o', 'clipboard', 'unnamed,unnamedplus')

cmd('let &colorcolumn = join(range(80,999), ",")') -- show column guide
cmd('au TextYankPost * lua vim.highlight.on_yank {on_visual = false}') -- highlight on yank

-- INTEGRATED TERMINAL --
utils.map('t', '<Esc>', '<C-\\><C-n>') -- go to normal mode on escape

-- start terminal in insert mode
cmd([[au BufEnter * if &buftype == 'terminal' | :startinsert | endif]])

-- hide line numbers in terminal windows
cmd('au BufEnter term://* setlocal nonumber norelativenumber signcolumn=no')
