local map = vim.keymap.set
local opts = { silent = true }

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
map("n", "<Leader>bn", ":BufferLineCycleNext<CR>", opts)
map("n", "<Leader>bp", ":BufferLineCyclePrev<CR>", opts)

-- These commands will move the current buffer backwards or forwards in the bufferline
map("n", "<Leader>bmn", ":BufferLineMoveNext<CR>", opts)
map("n", "<Leader>bmp", ":BufferLineMovePrev<CR>", opts)

-- These commands will sort buffers by directory, language, or a custom criteria
map("n", "<Leader>boe", ":BufferLineSortByExtension<CR>", opts)
map("n", "<Leader>bod", ":BufferLineSortByDirectory<CR>", opts)
map("n", "<Leader>boi", function()
    require("bufferline").sort_buffers_by(function(buf_a, buf_b)
        return buf_a.id < buf_b.id
    end)
end, opts)

-- Goto buffer
map("n", "<Leader>b1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<Leader>b2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<Leader>b3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<Leader>b4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<Leader>b5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<Leader>b6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<Leader>b7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<Leader>b8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<Leader>b9", ":BufferLineGoToBuffer 9<CR>", opts)

-- Pick buffer
map("n", "<Leader>bc", ":BufferLinePick<CR>", opts)

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        b = {
            name = "+buffer",
            ["1"] = "Goto 1",
            ["2"] = "Goto 2",
            ["3"] = "Goto 3",
            ["4"] = "Goto 4",
            ["5"] = "Goto 5",
            ["6"] = "Goto 6",
            ["7"] = "Goto 7",
            ["8"] = "Goto 8",
            ["9"] = "Goto Last",
            c = "Choose",
            n = "Next",
            p = "Previous",
            m = { name = "+move", n = "Next", p = "Previous" },
            o = { name = "+sort", d = "By Directory", e = "By Extension", i = "By ID" },
        },
    }, { prefix = "<leader>" })
end
