require("FTerm").setup({
    border = "rounded",
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

vim.api.nvim_create_user_command("Python", function()
    require("FTerm").run("pipenv run python")
end, { bang = true })
