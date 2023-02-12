return {
    "numtostr/FTerm.nvim",
    init = function()
        require("my.plugins.fterm.mappings")
    end,
    config = function()
        require("my.plugins.fterm.config")
    end,
}
