return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function() require("my.plugins.nvim-treesitter.config") end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
    },
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
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
