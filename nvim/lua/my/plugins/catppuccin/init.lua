require("catppuccin").setup({
    styles = {
        keywords = { "italic" },
    },
    dim_inactive = {
        enabled = true,
    },
    integrations = {
        dap = {
            enabled = true,
        },
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
    },
    highlight_overrides = {
        all = {
            SpellBad = { style = { "underdot" } },
            SpellCap = { style = { "underdot" } },
            SpellRare = { style = { "underdot" } },
            SpellLocal = { style = { "underdot" } },
        },
    },
})

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd("color catppuccin")
