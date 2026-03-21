return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function() require("my.plugins.nvim-treesitter.config") end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {
            opts = {
                enable_close_on_slash = true,
            },
            aliases = {
                smarty = "html",
            },
        },
    },
}
