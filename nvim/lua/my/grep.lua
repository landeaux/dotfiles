local function grep(args)
    local grepprg = vim.o.grepprg
    local cmd = grepprg .. " " .. table.concat(args, " ")
    return vim.fn.systemlist(cmd)
end

vim.api.nvim_create_user_command("Grep", function(input)
    local args = vim.split(input.args, " ")
    local lines = grep(args)
    vim.fn.setqflist({}, " ", { expr = true, title = "Grep Results", lines = lines })
    vim.cmd.cwindow()
end, { nargs = "+", complete = "file_in_path" })

vim.api.nvim_create_user_command("LGrep", function(input)
    local args = vim.split(input.args, " ")
    local lines = grep(args)
    vim.fn.setloclist(0, {}, " ", { expr = true, title = "LGrep Results", lines = lines })
    vim.cmd.lwindow()
end, { nargs = "+", complete = "file_in_path" })

-- vim.api.nvim_create_augroup("quickfix", {})
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--     group = "quickfix",
--     pattern = "cgetexpr",
--     callback = function()
--         vim.cmd.cwindow()
--     end,
-- })
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--     group = "quickfix",
--     pattern = "lgetexpr",
--     callback = function()
--         vim.cmd.lwindow()
--     end,
-- })
