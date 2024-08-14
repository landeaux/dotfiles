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
        diffview = true,
        fzf = true,
    },
    custom_highlights = {
        SpellBad = { style = { "underdotted" } },
        SpellCap = { style = { "underdotted" } },
        SpellRare = { style = { "underdotted" } },
        SpellLocal = { style = { "underdotted" } },
    },
})

vim.cmd.colorscheme("catppuccin")
