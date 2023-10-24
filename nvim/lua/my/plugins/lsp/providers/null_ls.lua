local null_ls = require("null-ls")

null_ls.setup({
    -- debug = true,
    sources = {
        -- Code Actions
        require("typescript.extensions.null-ls.code-actions"),
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.code_actions.shellcheck,
        -- Hover
        null_ls.builtins.hover.printenv,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc") -- Enable completion triggered by <c-x><c-o>
        require("my.plugins.lsp.mappings").register(client, bufnr)
    end,
})
