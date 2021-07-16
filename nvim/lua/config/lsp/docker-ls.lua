local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").dockerls.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
        "--stdio",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").common_on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = vim.loop.cwd,
})
