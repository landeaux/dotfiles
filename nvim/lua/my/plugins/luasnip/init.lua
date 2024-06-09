return {
    "L3MON4D3/LuaSnip",
    version = "v1.*",
    -- needed for Variable/Placeholder transformations
    -- (see: https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variable-transforms)
    build = "make install_jsregexp",
    config = function() require("my.plugins.luasnip.config") end,
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
}
