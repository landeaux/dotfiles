return {
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("my.plugins.nvim-dap-virtual-text.config") end,
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-treesitter/nvim-treesitter",
    },
}
