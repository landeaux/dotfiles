local map = require("my.utils").map_factory({ silent = true })

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map("n", "<Leader>bc", ":BufferLinePick<CR>", { desc = "Choose buffer" })
map("n", "<Leader>bn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<Leader>bp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<Leader>bmn", ":BufferLineMoveNext<CR>", { desc = "Move buffer next" })
map("n", "<Leader>bmp", ":BufferLineMovePrev<CR>", { desc = "Move buffer previous" })
map("n", "<Leader>bse", ":BufferLineSortByExtension<CR>", { desc = "Order buffers by extension" })
map("n", "<Leader>bsd", ":BufferLineSortByDirectory<CR>", { desc = "Order buffers by directory" })
