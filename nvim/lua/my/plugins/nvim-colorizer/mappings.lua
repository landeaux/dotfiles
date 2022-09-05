vim.keymap.set("n", "<Leader>tc", ":ColorizerToggle<CR>")

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({ t = { name = "+ui-toggle", c = "Colorizer" } }, { prefix = "<leader>" })
end
