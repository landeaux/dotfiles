return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", ":Oil<CR>", desc = "[Oil] Open parent directory", mode = { "n" } },
    },
    lazy = false,
}
