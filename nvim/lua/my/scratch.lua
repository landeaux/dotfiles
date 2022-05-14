local M = {}

M.scratch = function(vertical)
    local cmd = vertical and "vsplit" or "split"
    vim.cmd(cmd)
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
end

vim.api.nvim_create_user_command("Scratch", function()
    M.scratch(false)
end, { desc = "Open a scratch buffer in a horizontal split" })

vim.api.nvim_create_user_command("VScratch", function()
    M.scratch(true)
end, { desc = "Open a scratch buffer in a vertical split" })

vim.keymap.set({ "n", "v" }, "<Leader>sj", ":Scratch<CR>")
vim.keymap.set({ "n", "v" }, "<Leader>sl", ":VScratch<CR>")

return M
