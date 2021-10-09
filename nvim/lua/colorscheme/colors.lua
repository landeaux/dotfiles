local M = {}

function M.setup()
    local colors = {
        none = "NONE",
        red = "#ff0000",
        orange = "#ff8800",
        yellow = "#ffff00",
        green = "#00ff00",
        blue = "#0000ff",
        purple = "#8800ff",
        magenta = "#cc00ff",
        bg = "#000066",
        bg_dark = "#000040",
        gitSigns = {
            add = "#00ff00",
            change = "#0000ff",
            delete = "#ff0000",
        },
        error = "#ff0000",
        warning = "#ff8800",
        hint = "#6590ff",
        info = "#f6f6f6",
        debugging = {
            breakpoint_icon = "#aa0000",
            breakpoint_line = "#660000",
            conditional_breakpoint_icon = "#aa5500",
            conditional_breakpoint_line = "#663300",
            log_point_icon = "#aaaa00",
            log_point_line = "#666600",
            stopped_icon = "#0000aa",
            stopped_line = "#000066",
        },
    }

    local plugin_present, _ = pcall(require, "tokyonight")
    if plugin_present then
        local plugin_colors = require("tokyonight.colors").setup()
        local util = require("tokyonight.util")

        -- TODO: figure out how to merge two tables
        colors = {
            none = "NONE",
            red = plugin_colors.red,
            orange = plugin_colors.orange,
            yellow = plugin_colors.yellow,
            green = plugin_colors.green,
            blue = plugin_colors.blue,
            purple = plugin_colors.purple,
            magenta = plugin_colors.magenta,
            bg = plugin_colors.bg,
            bg_dark = plugin_colors.bg_dark,
            gitSigns = {
                add = plugin_colors.gitSigns.add,
                change = plugin_colors.gitSigns.change,
                delete = plugin_colors.gitSigns.delete,
            },
            error = plugin_colors.error,
            warning = plugin_colors.warning,
            hint = plugin_colors.hint,
            info = plugin_colors.info,
            debugging = {
                breakpoint_icon = util.darken(plugin_colors.red, 0.8),
                breakpoint_line = util.darken(plugin_colors.red, 0.3),
                conditional_breakpoint_icon = util.darken(plugin_colors.orange, 0.8),
                conditional_breakpoint_line = util.darken(plugin_colors.orange, 0.3),
                log_point_icon = util.darken(plugin_colors.yellow, 0.8),
                log_point_line = util.darken(plugin_colors.yellow, 0.3),
                stopped_icon = util.darken(plugin_colors.blue, 0.8),
                stopped_line = util.darken(plugin_colors.blue, 0.3),
            },
        }
    end

    return colors
end

return M
