local fterm = require("FTerm")

local M = {}

M.python = fterm:new({
    cmd = "python",
    border = vim.o.winborder,
})

M.ipython = fterm:new({
    cmd = "ipython",
    border = vim.o.winborder,
})

M.node = fterm:new({
    cmd = "node",
    border = vim.o.winborder,
})

M.top = fterm:new({
    cmd = "top",
    border = vim.o.winborder,
})

return M
