local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>ga", ":Git add -p<CR>", { desc = "Git add (patch)" })
map("n", "<Leader>gb", ":Git blame<CR>", { desc = "Git blame" })
map("n", "<Leader>gc", ":Git commit -v<CR>", { desc = "Git commit" })
map("n", "<Leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff" })
map("n", "<Leader>gm", ":Git commit --amend<CR>", { desc = "Git commit (amend)" })
map("n", "<Leader>gp", ":Git push<CR>", { desc = "Git push" })
map("n", "<Leader>gs", ":G<CR>", { desc = "Git status" })
