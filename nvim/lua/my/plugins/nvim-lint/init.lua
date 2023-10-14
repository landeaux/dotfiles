return {
    "mfussenegger/nvim-lint",
    commit = "0f54481d7537a6872f7bb021575366657e123474",
    config = function()
        require("lint").linters_by_ft = {
            dockerfile = { "hadolint" },
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            lua = { "luacheck" },
            python = { "flake8", "mypy", "pydocstyle" },
            markdown = { "markdownlint" },
            sh = { "shellcheck" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            vue = { "eslint_d" },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
            group = vim.api.nvim_create_augroup("_lint", { clear = true }),
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
