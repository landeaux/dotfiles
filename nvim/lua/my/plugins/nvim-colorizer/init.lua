require("my.plugins.nvim-colorizer.mappings")
require("colorizer").setup({
    filetypes = {
        "*",
        "!nvim-pack",
        "!oil",
    },
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
