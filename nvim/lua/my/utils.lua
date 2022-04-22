local M = {}

-- Create an augroup
function M.create_augroup(autocmds, group_name)
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })

    for _, autocmd in ipairs(autocmds) do
        local opts = vim.tbl_deep_extend("force", autocmd.opts, { group = group })
        vim.api.nvim_create_autocmd(autocmd.event, opts)
    end
end

-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_nagivation()
    local map = vim.keymap.set
    local opts = { buffer = true, silent = true }

    map({ "n", "o" }, "$", "g$", opts)
    map({ "n", "o" }, "0", "g0", opts)
    map({ "n", "o" }, "^", "g^", opts)
    map({ "n", "o" }, "j", "gj", opts)
    map({ "n", "o" }, "k", "gk", opts)

    map({ "n", "o" }, "<Down>", "gj", opts)
    map({ "n", "o" }, "<End>", "g<End>", opts)
    map({ "n", "o" }, "<Home>", "g<Home>", opts)
    map({ "n", "o" }, "<Up>", "gk", opts)

    map("i", "<Down>", "<C-o>gj", opts)
    map("i", "<End>", "<C-o>g<End>", opts)
    map("i", "<Home>", "<C-o>g<Home>", opts)
    map("i", "<Up>", "<C-o>gk", opts)
end

return M
