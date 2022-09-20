local char = "▏" -- "|", "│",

require("indent_blankline").setup({
    filetype_exclude = {
        "checkhealth",
        "git",
        "gitcommit",
        "help",
        "lspinfo",
        "man",
        "markdown",
        "neo-tree",
        "packer",
        "",
    },
    char = char,
    char_blankline = char,
    context_char = char,
    context_char_blankline = char,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    use_treesitter = true,
})
