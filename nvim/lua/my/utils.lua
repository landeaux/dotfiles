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
    local opts = { noremap = true, silent = true }
    local buf_bind = vim.api.nvim_buf_set_keymap

    buf_bind(0, "n", "k", "gk", opts)
    buf_bind(0, "n", "j", "gj", opts)
    buf_bind(0, "n", "0", "g0", opts)
    buf_bind(0, "n", "^", "g^", opts)
    buf_bind(0, "n", "$", "g$", opts)

    buf_bind(0, "n", "<Up>", "gk", opts)
    buf_bind(0, "n", "<Down>", "gj", opts)
    buf_bind(0, "n", "<Home>", "g<Home>", opts)
    buf_bind(0, "n", "<End>", "g<End>", opts)

    buf_bind(0, "o", "k", "gk", opts)
    buf_bind(0, "o", "j", "gj", opts)
    buf_bind(0, "o", "0", "g0", opts)
    buf_bind(0, "o", "^", "g^", opts)
    buf_bind(0, "o", "$", "g$", opts)

    buf_bind(0, "o", "<Up>", "gk", opts)
    buf_bind(0, "o", "<Down>", "gj", opts)
    buf_bind(0, "o", "<Home>", "g<Home>", opts)
    buf_bind(0, "o", "<End>", "g<End>", opts)

    buf_bind(0, "i", "<Up>", "<C-o>gk", opts)
    buf_bind(0, "i", "<Down>", "<C-o>gj", opts)
    buf_bind(0, "i", "<Home>", "<C-o>g<Home>", opts)
    buf_bind(0, "i", "<End>", "<C-o>g<End>", opts)
end

return M
