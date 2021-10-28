local gl = require("galaxyline")
local condition = require("galaxyline.condition")
local colors = require("my.config.ui.colorscheme").colors

local gls = gl.section

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

gls.left[1] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.magenta,
                [""] = colors.magenta,
                V = colors.magenta,
                c = colors.yellow,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.blue,
                t = colors.blue,
            }
            vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
            return "▊ "
        end,
        highlight = { colors.red, colors.bg_dark },
    },
}

vim.fn.getbufvar(0, "ts")

gls.left[2] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.orange, colors.bg_dark },
    },
}

gls.left[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.left[4] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors.gitSigns.add, colors.bg_dark },
    },
}
gls.left[5] = {
    DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = " 柳",
        highlight = { colors.gitSigns.change, colors.bg_dark },
    },
}
gls.left[6] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors.gitSigns.delete, colors.bg_dark },
    },
}

gls.right[1] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = { colors.error, colors.bg_dark },
    },
}
gls.right[2] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = { colors.warning, colors.bg_dark },
    },
}

gls.right[3] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = "  ",
        highlight = { colors.hint, colors.bg_dark },
    },
}

gls.right[4] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = "  ",
        highlight = { colors.info, colors.bg_dark },
    },
}

gls.right[5] = {
    ShowLspClient = {
        provider = "GetLspClient",
        condition = function()
            local tbl = { ["dashboard"] = true, [" "] = true, [""] = true }
            if tbl[vim.bo.filetype] then
                return false
            end
            return true
        end,
        icon = " ",
        highlight = { colors.green, colors.bg_dark },
    },
}

gls.right[6] = {
    LineInfo = {
        provider = "LineColumn",
        separator = "  ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.right[7] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.right[8] = {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.right[9] = {
    BufferType = {
        provider = "FileTypeName",
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.right[10] = {
    FileEncode = {
        provider = "FileEncode",
        condition = condition.hide_in_width,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.right[11] = {
    Space = {
        provider = function()
            return " "
        end,
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.orange, colors.bg_dark },
    },
}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = { "NONE", colors.bg_dark },
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.short_line_left[2] = {
    SFileName = {
        provider = "SFileName",
        condition = condition.buffer_not_empty,
        highlight = { colors.none, colors.bg_dark },
    },
}

gls.short_line_right[1] = {
    BufferIcon = { provider = "BufferIcon", highlight = { colors.none, colors.bg_dark } },
}
