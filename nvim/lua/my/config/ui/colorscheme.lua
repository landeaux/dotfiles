local M = {}

-- Make Terminal use GUI colors
-- vim.o.termguicolors = true

-- Set background color
-- vim.o.background = "dark"

-- TOKYO NIGHT
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.cmd("colorscheme tokyonight")

local config = require("tokyonight.config")
local colors = require("tokyonight.colors").setup(config)
local util = require("tokyonight.util")

-- NVCODE --
-- vim.cmd("colorscheme lunar")
-- vim.cmd("let g:nvcode_termcolors=256")

-- DRACULA --
-- vim.cmd('colorscheme dracula')

-- GRUVBOX --
-- cmd('colorscheme gruvbox')

M.colors = {
    none = "NONE",
    red = colors.red,
    orange = colors.orange,
    yellow = colors.yellow,
    green = colors.green,
    blue = colors.blue,
    purple = colors.purple,
    magenta = colors.magenta,
    bg = colors.bg,
    bg_dark = colors.bg_dark,
    gitSigns = {
        add = colors.gitSigns.add,
        change = colors.gitSigns.change,
        delete = colors.gitSigns.delete,
    },
    error = colors.error,
    warning = colors.warning,
    hint = colors.hint,
    info = colors.info,
    debugging = {
        breakpoint_icon = util.darken(colors.red, 0.8),
        breakpoint_line = util.darken(colors.red, 0.3),
        conditional_breakpoint_icon = util.darken(colors.orange, 0.8),
        conditional_breakpoint_line = util.darken(colors.orange, 0.3),
        log_point_icon = util.darken(colors.yellow, 0.8),
        log_point_line = util.darken(colors.yellow, 0.3),
        stopped_icon = util.darken(colors.blue, 0.8),
        stopped_line = util.darken(colors.blue, 0.3),
    },
}

return M
