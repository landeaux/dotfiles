local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        -- Code Actions
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.shellcheck,
        -- Hover
        null_ls.builtins.hover.printenv,
    },
    on_attach = function(client, bufnr)
        require("my.plugins.lsp.mappings").register(client, bufnr)
    end,
})
