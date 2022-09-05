local map = vim.keymap.set

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map("n", "<Leader>bn", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<Leader>bp", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })
map("n", "<Leader>bmn", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer next" })
map("n", "<Leader>bmp", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer previous" })

-- These commands will sort buffers by directory, language, or a custom criteria
map(
    "n",
    "<Leader>boe",
    ":BufferLineSortByExtension<CR>",
    { silent = true, desc = "Order buffers by extension" }
)
map(
    "n",
    "<Leader>bod",
    ":BufferLineSortByDirectory<CR>",
    { silent = true, desc = "Order buffers by directory" }
)
map("n", "<Leader>boi", function()
    require("bufferline").sort_buffers_by(function(buf_a, buf_b)
        return buf_a.id < buf_b.id
    end)
end, { silent = true, desc = "Order buffers by id" })

map("n", "<Leader>bc", ":BufferLinePick<CR>", { silent = true, desc = "Choose buffer" })

-- Goto buffer
map("n", "<Leader>b1", ":BufferLineGoToBuffer 1<CR>", { silent = true, desc = "Goto buffer 1" })
map("n", "<Leader>b2", ":BufferLineGoToBuffer 2<CR>", { silent = true, desc = "Goto buffer 2" })
map("n", "<Leader>b3", ":BufferLineGoToBuffer 3<CR>", { silent = true, desc = "Goto buffer 3" })
map("n", "<Leader>b4", ":BufferLineGoToBuffer 4<CR>", { silent = true, desc = "Goto buffer 4" })
map("n", "<Leader>b5", ":BufferLineGoToBuffer 5<CR>", { silent = true, desc = "Goto buffer 5" })
map("n", "<Leader>b6", ":BufferLineGoToBuffer 6<CR>", { silent = true, desc = "Goto buffer 6" })
map("n", "<Leader>b7", ":BufferLineGoToBuffer 7<CR>", { silent = true, desc = "Goto buffer 7" })
map("n", "<Leader>b8", ":BufferLineGoToBuffer 8<CR>", { silent = true, desc = "Goto buffer 8" })
map("n", "<Leader>b9", ":BufferLineGoToBuffer 9<CR>", { silent = true, desc = "Goto buffer 9" })

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        b = {
            name = "+buffer",
            m = { name = "+move" },
            o = { name = "+order" },
        },
    }, { prefix = "<leader>" })
end
