return {
    "rebelot/kanagawa.nvim",
    lazy = false, -- load this during startup if it is the main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() vim.cmd.colorscheme("kanagawa-dragon") end,
}
