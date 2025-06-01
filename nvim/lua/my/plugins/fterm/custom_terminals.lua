local fterm = require("FTerm")

local M = {}

---Prefix the given command with `pipenv run` if needed
---@param cmd string
---@return string
local pipenv_prefix = function(cmd)
    local prefix = ""
    if vim.env.PIPENV_ACTIVE then
        prefix = "pipenv run "
    end
    return prefix .. cmd
end

M.python = fterm:new({
    cmd = pipenv_prefix("python"),
    border = vim.o.winborder,
})

M.ipython = fterm:new({
    cmd = pipenv_prefix("ipython"),
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
