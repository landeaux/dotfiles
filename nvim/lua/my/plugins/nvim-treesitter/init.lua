return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function() require("my.plugins.nvim-treesitter.config") end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            aliases = {
                smarty = "html",
            },
            enable_close_on_slash = true,
        },
    },
}
