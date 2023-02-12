return {
    "L3MON4D3/LuaSnip",
    version = "v1.*",
    config = function()
        require("my.plugins.luasnip.config")
    end,
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
}
