return {
    "catgoose/nvim-colorizer.lua",
    init = function() require("my.plugins.nvim-colorizer.mappings") end,
    opts = {
        user_default_options = {
            names = false,
        },
    },
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
    },
}
