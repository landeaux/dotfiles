local utils = require('utils')

local cmd = vim.cmd
local g = vim.g

g.indentLine_enabled = 1
g.indent_blankline_char = '▏'
g.indent_blankline_space_char = ' '

cmd('hi IndentBlanklineChar guifg=#373b43')

g.indent_blankline_filetype_exclude = { 'help', 'terminal' }
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false
