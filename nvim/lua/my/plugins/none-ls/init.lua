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
                -- Prevent mypy from running on injected Python code blocks in markdown files.
                -- none-ls's injection handling bypasses the filetypes gate, so runtime_condition
                -- is the only way to restrict this to native Python buffers.
                null_ls.builtins.diagnostics.mypy.with({
                    temp_dir = "/tmp",
                    runtime_condition = function(params) return vim.bo[params.bufnr].filetype == "python" end,
                }),
                null_ls.builtins.diagnostics.markdownlint_cli2.with({
                    extra_args = { "--config", vim.fn.expand("~/.markdownlint-cli2.jsonc") },
                }),
            },
        })
    end,
}
