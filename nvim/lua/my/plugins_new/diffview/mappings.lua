local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>go", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
map("n", "<Leader>gq", ":DiffviewClose<CR>", { desc = "Close Diffview" })
map("n", "<Leader>gl", ":DiffviewFileHistory<CR>", { desc = "Diffview File History" })
