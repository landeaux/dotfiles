return {
    "catgoose/nvim-colorizer.lua",
    init = function() require("my.plugins.nvim-colorizer.mappings") end,
    opts = {},
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
    },
}
