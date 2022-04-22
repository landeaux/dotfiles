require("FTerm").setup({
    border = "rounded",
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<A-i>", function()
    require("FTerm").toggle()
end, opts)
map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
