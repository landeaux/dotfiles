vim.keymap.set("n", "<Leader>tn", ":Neotree filesystem reveal left toggle<CR>", { silent = true })

require("which-key").register({
    t = { name = "+ui-toggle", n = "File Tree" },
}, {
    prefix = "<leader>",
})
