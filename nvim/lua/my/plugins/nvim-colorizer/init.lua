require("my.plugins.nvim-colorizer.mappings")
require("nvim-colorizer").setup({
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
})
