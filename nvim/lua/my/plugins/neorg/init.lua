return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("my.plugins.neorg.config")
    end,
    cmd = { "Neorg" },
    ft = "norg",
}
