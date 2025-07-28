return {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = {
        "KittyScrollbackGenerateKittens",
        "KittyScrollbackCheckHealth",
        "KittyScrollbackGenerateCommandLineEditing",
    },
    event = { "User KittyScrollbackLaunch" },
    version = "^6.0.0", -- latest stable version, may have breaking changes if major version changed
    config = function() require("kitty-scrollback").setup() end,
}
