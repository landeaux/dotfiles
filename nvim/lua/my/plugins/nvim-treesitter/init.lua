return {
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "19ac9e8b5c1e5eedd2ae7957243e25b32e269ea7",
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
            }
        },
    },
}
