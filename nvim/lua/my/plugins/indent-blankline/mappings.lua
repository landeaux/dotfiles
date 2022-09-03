vim.keymap.set("n", "<Leader>ti", "<cmd>IndentBlanklineToggle<CR>", { silent = true })

require("which-key").register(
    { t = { name = "+ui-toggle", i = "Indent guides" } },
    { prefix = "<leader>" }
)
