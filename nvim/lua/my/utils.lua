local M = {}

---Create an augroup
---@param autocmds table
---@param group_name string
function M.create_augroup(autocmds, group_name)
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })

    for _, autocmd in ipairs(autocmds) do
        local opts = vim.tbl_deep_extend("force", autocmd.opts, { group = group })
        vim.api.nvim_create_autocmd(autocmd.event, opts)
    end
end

---Factory function for building a wrapper around vim.keymap.set with default options
---@param default_opts table
---@return function
function M.map_factory(default_opts)
    default_opts = default_opts or {}
    local _map = function(mode, l, r, opts)
        opts = opts or {}
        local merged_opts = vim.tbl_deep_extend("force", default_opts, opts)
        vim.keymap.set(mode, l, r, merged_opts)
    end
    return _map
end

---Make navigation keys navigate through display lines instead of physical lines
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

---Check if the project in the current working directory is a Vue project
---@return boolean
function M.is_vue_project()
    local package_json_path = vim.fn.getcwd() .. "/package.json"
    if vim.fn.filereadable(package_json_path) == 0 then
        return false
    end

    local file = io.open(package_json_path, "r")
    if file then
        local content = file:read("*a")
        file:close()
        if content:match('"vue":') then
            return true
        end
    end

    return false
end

return M
