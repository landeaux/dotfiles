local map = vim.keymap.set

map("n", "<Leader>ga", ":Git add -p<CR>", { silent = true, desc = "Git add (patch)" })
map("n", "<Leader>gb", ":Git blame<CR>", { silent = true, desc = "Git blame" } )
map("n", "<Leader>gc", ":Git commit -v<CR>", { silent = true, desc = "Git commit" })
map("n", "<Leader>gd", ":Gdiffsplit<CR>", { silent = true, desc = "Git diff" })
map("n", "<Leader>gm", ":Git commit --amend<CR>", { silent = true, desc = "Git commit (amend)" })
map("n", "<Leader>gp", ":Git push<CR>", { silent = true, desc = "Git push" })
map("n", "<Leader>gs", ":G<CR>", { silent = true, desc = "Git status" })
