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
    },
    on_attach = function(bufnr)
        require("my.plugins.gitsigns.mappings").register(bufnr)
    end,
})
