return {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "aa44e5f",
    build = ":TSUpdate",
    config = function()
        require("my.plugins.nvim-treesitter.config")
    end,
    dependencies = {
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
