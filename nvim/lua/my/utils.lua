local M = {}

-- Create an augroup
function M.create_augroup(autocmds, group_name)
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })

    for _, autocmd in ipairs(autocmds) do
        local opts = vim.tbl_deep_extend("force", autocmd.opts, { group = group })
        vim.api.nvim_create_autocmd(autocmd.event, opts)
    end
end

function M.map_factory(default_opts)
    default_opts = default_opts or {}
    local _map = function(mode, l, r, opts)
        opts = opts or {}
        local merged_opts = vim.tbl_deep_extend("force", opts, default_opts)
        vim.keymap.set(mode, l, r, merged_opts)
    end
    return _map
end

-- Make navigation keys navigate through display lines instead of physical lines
function M.set_buffer_soft_line_nagivation()
    local map = M.map_factory({ buffer = true, silent = true })

    map({ "n", "o" }, "$", "g$")
    map({ "n", "o" }, "0", "g0")
    map({ "n", "o" }, "^", "g^")
    map({ "n", "o" }, "j", "gj")
    map({ "n", "o" }, "k", "gk")

    map({ "n", "o" }, "<Down>", "gj")
    map({ "n", "o" }, "<End>", "g<End>")
    map({ "n", "o" }, "<Home>", "g<Home>")
    map({ "n", "o" }, "<Up>", "gk")

    map("i", "<Down>", "<C-o>gj")
    map("i", "<End>", "<C-o>g<End>")
    map("i", "<Home>", "<C-o>g<Home>")
    map("i", "<Up>", "<C-o>gk")
end

return M
