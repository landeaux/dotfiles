---@diagnostic disable-next-line: missing-fields
require("kanagawa").setup({
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none",
                },
            },
        },
    },
    overrides = function(colors)
        local theme = colors.theme
        return {
            -- dark popup menu
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },

            -- fix blink.cmp highlights (see https://github.com/rebelot/kanagawa.nvim/issues/283#issuecomment-2766568473)
            BlinkCmpMenu = { bg = colors.palette.dragonBlack3 },
            BlinkCmpMenuBorder = { bg = colors.palette.dragonBlack3 },
            BlinkCmpLabelDetail = { bg = colors.palette.dragonBlack3 },
            BlinkCmpMenuSelection = { bg = colors.palette.waveBlue1 },

            -- spelling
            SpellBad = { underdotted = true },
            SpellCap = { underdotted = true },
            SpellRare = { underdotted = true },
            SpellLocal = { underdotted = true },
        }
    end,
})

vim.cmd.colorscheme("kanagawa-dragon")
