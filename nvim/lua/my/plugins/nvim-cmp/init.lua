return {
    "hrsh7th/nvim-cmp",
    config = function()
        require("my.plugins.nvim-cmp.config")
    end,
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "windwp/nvim-autopairs",
    },
    event = "InsertEnter",
}
