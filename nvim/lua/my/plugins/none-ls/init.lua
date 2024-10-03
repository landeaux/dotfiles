return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.hadolint,
                require("none-ls.diagnostics.eslint_d"),
                null_ls.builtins.diagnostics.selene,
                null_ls.builtins.diagnostics.mypy.with({ temp_dir = "/tmp" }),
                null_ls.builtins.diagnostics.markdownlint,
            },
        })
    end,
}
