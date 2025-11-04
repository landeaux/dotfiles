return {
    "catgoose/nvim-colorizer.lua",
    init = function() require("my.plugins.nvim-colorizer.mappings") end,
    opts = {
        user_default_options = {
            names = false,
            css = true,
            tailwind = "lsp",
            mode = "virtualtext",
            virtualtext_inline = "after",
        },
    },
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
    },
}
