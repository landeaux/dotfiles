vim.keymap.set("n", "<Leader>lf", "<CMD>Format<CR>", { desc = "Format buffer", silent = true })
vim.keymap.set("v", "<Leader>lf", "<CMD>'<,'>Format<CR>", { desc = "Format visual selection", silent = true })
