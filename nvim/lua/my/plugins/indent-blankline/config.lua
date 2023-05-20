local char = "▏" -- "|", "│",

require("indent_blankline").setup({
    filetype_exclude = {
        "",
        "checkhealth",
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
    char = char,
    char_blankline = char,
    context_char = char,
    context_char_blankline = char,
    show_trailing_blankline_indent = false,
    show_current_context = true,
})
