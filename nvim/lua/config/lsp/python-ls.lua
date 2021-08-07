-- npm i -g pyright
require("lspconfig").pyright.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
        "--stdio",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").common_on_attach,
    flags = {
        debounce_text_changes = 1500,
    },
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
            },
            venvPath = vim.env.PYENV_ROOT,
        },
    },
})
