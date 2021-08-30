local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}

-- npm i -g intelephense
require("lspconfig").intelephense.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/php/node_modules/.bin/intelephense",
        "--stdio",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").common_on_attach,
    flags = {
        debounce_text_changes = 1500,
    },
})
