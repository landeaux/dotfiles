return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("my.plugins.nvim-autopairs.config") end,
}
