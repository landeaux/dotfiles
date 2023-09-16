return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- load this during startup if it is the main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("my.plugins.catppuccin.config")
    end,
}
