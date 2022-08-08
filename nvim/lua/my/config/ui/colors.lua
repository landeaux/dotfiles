local ok, _ = pcall(require, "zenbones")

if not ok then
    return false
end

local themeColors = require("zenbones.palette").dark

local colors = {
    none = "NONE",
    red = themeColors.rose.hex,
    orange = themeColors.wood.hex,
    yellow = themeColors.wood.hex,
    green = themeColors.leaf.hex,
    blue = themeColors.sky.hex,
    purple = themeColors.blossom.darken(30).hex,
    magenta = themeColors.blossom.hex,
    bg = themeColors.bg.hex,
    bg_dark = themeColors.bg.darken(30).hex,
    gitSigns = {
        add = themeColors.leaf.darken(20).hex,
        change = themeColors.sky.darken(20).hex,
        delete = themeColors.rose.darken(20).hex,
    },
    error = themeColors.rose.hex,
    warning = themeColors.wood.hex,
    hint = themeColors.sky.hex,
    info = themeColors.blossom.hex,
    debugging = {
        breakpoint_icon = themeColors.rose.darken(30).hex,
        breakpoint_line = themeColors.rose.darken(80).hex,
        conditional_breakpoint_icon = themeColors.wood.darken(30).hex,
        conditional_breakpoint_line = themeColors.wood.darken(80).hex,
        log_point_icon = themeColors.blossom.darken(30).hex,
        log_point_line = themeColors.blossom.darken(80).hex,
        stopped_icon = themeColors.sky.darken(30).hex,
        stopped_line = themeColors.sky.darken(80).hex,
    },
}

return colors
