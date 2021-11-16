local on_attach = require("my.config.lsp.providers.defaults").on_attach
local null_ls = require("null-ls")

-- TODO: add handler for pandoc (maybe the markdownlint formatter is better?)
-- TODO: add handler for and pydocstyle
-- TODO: check out remaining commented-out builtins to see if they are a good fit

null_ls.config({
    -- debug = true,
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.shfmt,
        -- null_ls.builtins.formatting.stylint,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.mypy,
        -- null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.diagnostics.shellcheck,
        -- null_ls.builtins.diagnostics.luacheck,
        -- null_ls.builtins.diagnostics.stylint,
        -- null_ls.builtins.diagnostics.yamllint,
        -- null_ls.builtins.hover.dictionary,
    },
})

require("lspconfig")["null-ls"].setup({
    on_attach = on_attach,
})
