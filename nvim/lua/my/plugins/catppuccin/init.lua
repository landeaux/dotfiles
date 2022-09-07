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
            enable_ui = true,
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
        which_key = true,
    },
})

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.cmd("color catppuccin")
