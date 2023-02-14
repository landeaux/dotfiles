local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        -- Code Actions
        require("typescript.extensions.null-ls.code-actions"),
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.shellcheck,
        -- Diagnostics
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.flake8.with({ temp_dir = "/tmp" }),
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.mypy.with({ temp_dir = "/tmp" }),
        null_ls.builtins.diagnostics.pydocstyle.with({
            temp_dir = "/tmp",
            diagnostics_format = "#{m} (#{c})",
            extra_args = { "--config=$ROOT/pyproject.toml" },
            -- Don't lint test files
            runtime_condition = function(params)
                -- NOTE: For some reason pydocstyle refuses to respect the
                -- match argument when run through null-ls. So I guess we'll
                -- just do it manually...
                local fname = vim.fn.fnamemodify(params.bufname, ":t:r")
                return not vim.startswith(fname, "test_")
            end,
        }),
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.hadolint,
        -- Formatting
        -- NOTE: these must be placed in the order we want them to run
        null_ls.builtins.formatting.isort.with({ temp_dir = "/tmp" }),
        null_ls.builtins.formatting.black.with({ temp_dir = "/tmp" }),
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.trim_whitespace,
        -- Hover
        null_ls.builtins.hover.printenv,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc") -- Enable completion triggered by <c-x><c-o>
        require("my.plugins.lsp.mappings").register(client, bufnr)
    end,
})
