local ok, _ = pcall(require, "tokyonight")

if not ok then
    return false
end

local themeColors = require("tokyonight.colors").setup()
local util = require("tokyonight.util")

local colors = {
    none = "NONE",
    red = themeColors.red,
    orange = themeColors.orange,
    yellow = themeColors.yellow,
    green = themeColors.green,
    blue = themeColors.blue,
    purple = themeColors.purple,
    magenta = themeColors.magenta,
    bg = themeColors.bg,
    bg_dark = themeColors.bg_dark,
    gitSigns = {
        add = themeColors.gitSigns.add,
        change = themeColors.gitSigns.change,
        delete = themeColors.gitSigns.delete,
    },
    error = themeColors.error,
    warning = themeColors.warning,
    hint = themeColors.hint,
    info = themeColors.info,
    debugging = {
        breakpoint_icon = util.darken(themeColors.red, 0.8),
        breakpoint_line = util.darken(themeColors.red, 0.3),
        conditional_breakpoint_icon = util.darken(themeColors.orange, 0.8),
        conditional_breakpoint_line = util.darken(themeColors.orange, 0.3),
        log_point_icon = util.darken(themeColors.yellow, 0.8),
        log_point_line = util.darken(themeColors.yellow, 0.3),
        stopped_icon = util.darken(themeColors.blue, 0.8),
        stopped_line = util.darken(themeColors.blue, 0.3),
    },
}

return colors
