vim.o.termguicolors = true
vim.o.background = "dark"

---- Tokyonight
vim.g.tokyonight_style = "night"
vim.g.tokyonight_sidebars = { "qf", "packer", "terminal" }
-- vim.cmd("color tokyonight")

---- Zenbones
-- vim.cmd("color zenbones")

---- Catppuccin
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
    -- This is a comment
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
vim.cmd("color catppuccin")