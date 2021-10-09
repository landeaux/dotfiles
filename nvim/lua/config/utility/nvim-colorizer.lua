require("colorizer").setup()

vim.api.nvim_set_keymap("n", "<Leader>tc", ":ColorizerToggle<CR>", { noremap = true })

require("whichkey_setup").register_keymap(
    "leader",
    { t = { name = "+ui-toggle", c = "Colorizer" } }
)
