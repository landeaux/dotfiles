local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
    cmd = {
        "node",
        vim.fn.stdpath("data")
            .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").common_on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
})
