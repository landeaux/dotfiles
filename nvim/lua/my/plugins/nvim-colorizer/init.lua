return {
    "norcalli/nvim-colorizer.lua",
    init = function() require("my.plugins.nvim-colorizer.mappings") end,
    config = function() require("my.plugins.nvim-colorizer.config") end,
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerDetachFromBuffer",
        "ColorizerReloadAllBuffers",
        "ColorizerToggle",
    },
}
