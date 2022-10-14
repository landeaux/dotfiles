require("catppuccin").setup({
    styles = {
        keywords = { "italic" },
    },
    dim_inactive = {
        enabled = true,
    },
    integrations = {
        native_lsp = {
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
        neotree = {
            enabled = true,
            show_root = true,
        },
        mason = true,
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

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd("color catppuccin")
