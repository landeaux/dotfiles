local char = "▏" -- "|", "│",

require("ibl").setup({
    exclude = {
        filetypes = {
            "",
            "checkhealth",
            "fugitive",
            "git",
            "gitcommit",
            "help",
            "lazy",
            "lspinfo",
            "man",
            "markdown",
            "mason",
            "neo-tree",
        },
    },
    indent = {
        char = char,
    },
    scope = {
        show_start = false,
        show_end = false,
    },
})
