vim.keymap.set("n", "<Leader>tc", ":ColorizerToggle<CR>")

require("which-key").register(
    { t = { name = "+ui-toggle", c = "Colorizer" } },
    { prefix = "<leader>" }
)
