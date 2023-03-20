require("gitsigns").setup({
    signs = {
        add = {
            text = "▎",
        },
        change = {
            text = "▎",
        },
        changedelete = {
            text = "▎",
        },
        untracked = {
            text = "▎",
        },
    },
    preview_config = {
        border = "rounded",
    },
    on_attach = function(bufnr)
        require("my.plugins.gitsigns.mappings").register(bufnr)
    end,
})
