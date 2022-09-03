local map = vim.keymap.set
local opts = { silent = true }

map("n", "<A-i>", function()
    require("FTerm").toggle()
end, opts)
map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- TODO: register whichkey mapping
