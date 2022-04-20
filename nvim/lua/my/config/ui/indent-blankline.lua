require("indent_blankline").setup({
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "dashboard",
        "git",
        "gitcommit",
        "help",
        "markdown",
        "neo-tree",
        "packer",
        "undotree",
    },
    char = "▏",
    -- char = "|",
    -- char = "│",
    -- char_highlight = "LineNr",
    indent_level = 10,
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = false,
    space_char_blankline = " ",
    use_treesitter = true,
    -- context_patterns = {
    --     "class",
    --     "function",
    --     "method",
    --     "^if",
    --     "^while",
    --     "^for",
    --     "^object",
    --     "^table",
    --     "block",
    --     "arguments",
    -- },
    context_patterns = {
        "^func",
        "^if",
        "argument_list",
        "arguments",
        "block",
        "class",
        "dictionary",
        "element",
        "except",
        "for",
        "method",
        "object",
        "table",
        "try",
        "tuple",
        "while",
        "with",
    },
})

vim.api.nvim_set_keymap(
    "n",
    "<Leader>ti",
    "<cmd>IndentBlanklineToggle<CR>",
    { noremap = true, silent = true }
)

require("whichkey_setup").register_keymap(
    "leader",
    { t = { name = "+ui-toggle", i = "Indent guides" } }
)
