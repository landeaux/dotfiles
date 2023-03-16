require("FTerm").setup({
    border = "rounded",
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

vim.api.nvim_create_user_command("Python", function()
    local prefix = ""
    if vim.env.PIPENV_ACTIVE then
        prefix = "pipenv run "
    end
    require("FTerm").run(prefix .. "python")
end, {
    bang = true,
})

vim.api.nvim_create_user_command("IPython", function()
    local prefix = ""
    if vim.env.PIPENV_ACTIVE then
        prefix = "pipenv run "
    end
    require("FTerm").run(prefix .. "ipython")
end, {
    bang = true,
})

vim.api.nvim_create_user_command("Node", function()
    require("FTerm").run("node")
end, {
    bang = true,
})
