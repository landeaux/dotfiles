return {
    "rebelot/kanagawa.nvim",
    lazy = false, -- load this during startup if it is the main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
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
                return {
                    SpellBad = { underdotted = true },
                    SpellCap = { underdotted = true },
                    SpellRare = { underdotted = true },
                    SpellLocal = { underdotted = true },
                }
            end,
        })

        vim.cmd.colorscheme("kanagawa-dragon")
    end,
}
