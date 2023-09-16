require("catppuccin").setup({
    styles = {
        keywords = { "italic" },
    },
    dim_inactive = {
        enabled = true,
    },
    integrations = {
        native_lsp = {
            enabled = true,
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
        mason = true,
        markdown = true,
        treesitter = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
    },
    highlight_overrides = {
        all = {
            SpellBad = { style = { "underdotted" } },
            SpellCap = { style = { "underdotted" } },
            SpellRare = { style = { "underdotted" } },
            SpellLocal = { style = { "underdotted" } },
        },
    },
})

vim.cmd.colorscheme("catppuccin")
