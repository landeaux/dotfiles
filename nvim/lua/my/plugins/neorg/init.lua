return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    tag = "v7.0.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("my.plugins.neorg.config") end,
    cmd = { "Neorg" },
    ft = "norg",
}
