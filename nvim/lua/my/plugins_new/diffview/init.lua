return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- optional
    },
    init = function()
        require("my.plugins_new.diffview.mappings")
    end,
    config = function()
        require("my.plugins_new.diffview.config")
    end,
    cmd = {
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewFocusFiles",
        "DiffviewLog",
        "DiffviewOpen",
        "DiffviewRefresh",
        "DiffviewToggleFiles",
    },
}
