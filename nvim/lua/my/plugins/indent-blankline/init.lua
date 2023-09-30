return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    init = function()
        require("my.plugins.indent-blankline.mappings")
    end,
    config = function()
        require("my.plugins.indent-blankline.config")
    end,
}
