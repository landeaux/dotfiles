return {
    "numtostr/FTerm.nvim",
    init = function()
        require("my.plugins_new.fterm.mappings")
    end,
    config = function()
        require("my.plugins_new.fterm.config")
    end,
}
