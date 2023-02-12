return {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
        require("my.plugins_new.indent-blankline.mappings")
    end,
    config = function()
        require("my.plugins_new.indent-blankline.config")
    end,
}
