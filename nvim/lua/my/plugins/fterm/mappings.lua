local map = require("my.utils").map_factory({ silent = true })

map("n", "<A-i>", function()
    require("FTerm").toggle()
end, { desc = "Toggle terminal" })
map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle terminal" })

map("n", "<A-p>", function()
    require("FTerm").toggle()
end, { desc = "Invoke python shell (via pipenv)" })
