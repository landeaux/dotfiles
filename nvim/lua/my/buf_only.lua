local M = {}

M.buf_only = function()
    vim.fn.execute("%bd|e#|bd#")
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
