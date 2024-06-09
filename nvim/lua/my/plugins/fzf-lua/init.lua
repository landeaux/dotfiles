return {
    "ibhagwan/fzf-lua",
    init = function() require("my.plugins.fzf-lua.mappings") end,
    config = function() require("my.plugins.fzf-lua.config") end,
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icon support
}
