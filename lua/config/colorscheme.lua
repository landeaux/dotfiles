local colorscheme = { }
local utils = require('utils')
local cmd = vim.cmd

utils.opt('o', 'termguicolors', true)

-- DRACULA --
cmd('colorscheme dracula')

colorscheme.dracula = {
  red = utils.get_hi_term('DraculaRed', 'guifg'),
  pink = utils.get_hi_term('DraculaPink', 'guifg'),
  orange = utils.get_hi_term('DraculaOrange', 'guifg'),
  yellow = utils.get_hi_term('DraculaYellow', 'guifg'),
  green = utils.get_hi_term('DraculaGreen', 'guifg'),
  cyan = utils.get_hi_term('DraculaCyan', 'guifg'),
  purple = utils.get_hi_term('DraculaPurple', 'guifg'),
  fg = utils.get_hi_term('DraculaFg', 'guifg'),
  bg_light = utils.get_hi_term('DraculaBgLight', 'guibg'),
  bg_lighter = utils.get_hi_term('DraculaBgLighter', 'guibg'),
  bg_dark = utils.get_hi_term('DraculaBgDark', 'guibg'),
  bg_darker = utils.get_hi_term('DraculaBgDarker', 'guibg'),
  subtle = utils.get_hi_term('DraculaSubtle', 'guifg'),
  comment = utils.get_hi_term('DraculaComment', 'guifg'),
}

-- GRUVBOX --
-- cmd('colorscheme gruvbox')
-- utils.opt('o', 'background', 'dark')

return colorscheme
