local colorscheme = {}

-- Make Terminal use GUI colors
vim.o.termguicolors = true

-- Set background color
vim.o.background = 'dark'

-- NVCODE --
vim.cmd('colorscheme lunar')
vim.cmd('let g:nvcode_termcolors=256')

-- DRACULA --
-- vim.cmd('colorscheme dracula')

-- local function get_dracula_palette_hex(key)
--   return vim.g['dracula#palette'][key][1]
-- end

-- colorscheme.dracula = {
--   fg = get_dracula_palette_hex('fg'),
-- 
--   bg_lighter = get_dracula_palette_hex('bglighter'),
--   bg_light = get_dracula_palette_hex('bglight'),
--   bg = get_dracula_palette_hex('bg'),
--   bg_dark = get_dracula_palette_hex('bgdark'),
--   bg_darker = get_dracula_palette_hex('bgdarker'),
-- 
--   comment = get_dracula_palette_hex('comment'),
--   selection = get_dracula_palette_hex('selection'),
--   subtle = get_dracula_palette_hex('subtle'),
-- 
--   cyan = get_dracula_palette_hex('cyan'),
--   green = get_dracula_palette_hex('green'),
--   orange = get_dracula_palette_hex('orange'),
--   pink = get_dracula_palette_hex('pink'),
--   purple = get_dracula_palette_hex('purple'),
--   red = get_dracula_palette_hex('red'),
--   yellow = get_dracula_palette_hex('yellow'),
-- }

-- GRUVBOX --
-- cmd('colorscheme gruvbox')

return colorscheme
