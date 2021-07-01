local colorscheme = {}

-- Make Terminal use GUI colors
vim.o.termguicolors = true

-- Set background color
vim.o.background = "dark"

-- TOKYO NIGHT
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.cmd("colorscheme tokyonight")

-- NVCODE --
-- vim.cmd("colorscheme lunar")
-- vim.cmd("let g:nvcode_termcolors=256")

-- DRACULA --
-- vim.cmd('colorscheme dracula')

-- GRUVBOX --
-- cmd('colorscheme gruvbox')

return colorscheme
