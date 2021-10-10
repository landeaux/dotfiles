require("indent_blankline").setup({
    buftype_exclude = { "terminal", "nofile", "help" },
    filetype_exclude = {
        "help",
        "dashboard",
        "NvimTree",
        "undotree",
        "packer",
        "git",
        "gitcommit",
    },
    char = "▏",
    -- char = "|",
    -- char = "│",
    char_highlight = "LineNr",
    indent_level = 10,
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_end_of_line = false,
    space_char_blankline = " ",
    use_treesitter = true,
    context_patterns = {
        "class",
        "function",
        "method",
        "^if",
        "^while",
        "^for",
        "^object",
        "^table",
        "block",
        "arguments",
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
