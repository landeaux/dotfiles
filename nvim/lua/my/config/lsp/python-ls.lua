-- npm i -g pyright
require("lspconfig").pyright.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 1500,
    },
    capabilities = require("my.config.lsp.nvim-lsp-settings").capabilities,
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
            },
            venvPath = vim.env.PYENV_ROOT,
        },
    },
    on_attach = require("my.config.lsp.nvim-lsp-settings").common_on_attach,
})
