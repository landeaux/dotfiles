local map = require("my.utils").map_factory({ silent = true })

map("n", "<Leader>gvc", ":GV!<CR>", { desc = "List commits that affected current file" })
map("n", "<Leader>gvl", ":GV?<CR>", { desc = "Fill location list with revisions of current file" })
map("n", "<Leader>gvo", ":GV<CR>", { desc = "Open commit browser" })
