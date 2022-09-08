local M = {}

-- M.buf_only = function()
--     vim.fn.execute("%bd|e#|bd#")
-- end

local buf_opt = vim.api.nvim_buf_get_option

function M.buf_only()
    local cur = vim.api.nvim_get_current_buf()

    for _, n in ipairs(vim.api.nvim_list_bufs()) do
        if
            n == cur
            or buf_opt(n, "modified")
            or buf_opt(n, "buftype") == "terminal"
            or not buf_opt(n, "modifiable")
        then
            return
        end
        vim.api.nvim_buf_delete(n, {})
    end
end

vim.api.nvim_create_user_command("BufOnly", function()
    M.buf_only()
end, {
    desc = "Close all buffers except the current one",
})

vim.keymap.set(
    "n",
    "<Leader>bo",
    ":BufOnly<CR>",
    { desc = "Close all buffers except the current one", silent = true }
)

return M
