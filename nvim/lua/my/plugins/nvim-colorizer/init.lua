return {
    "catgoose/nvim-colorizer.lua",
    init = function() require("my.plugins.nvim-colorizer.mappings") end,
    opts = {
        options = {
            parsers = {
                names = { enable = false },
                css = true,
                tailwind = { enable = true, lsp = true },
            },
            display = {
                mode = "virtualtext",
                virtualtext = {
                    position = "after",
                },
            },
        },
    },
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
    },
}
