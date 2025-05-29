return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master", -- TODO: migrate to main branch
        build = ":TSUpdate",
        lazy = false,
        config = function() require("my.plugins.nvim-treesitter.config") end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
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
