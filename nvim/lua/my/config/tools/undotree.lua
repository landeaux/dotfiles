vim.keymap.set("n", "<Leader>tu", ":UndotreeToggle<CR>")

require("which-key").register({
    t = { name = "+ui-toggle", u = "UndoTree" },
}, {
    prefix = "<leader>",
})
