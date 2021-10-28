-- npm install -g @volar/server
require("lspconfig").volar.setup({
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("my.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = function(client, bufnr)
        require("my.config.lsp.nvim-lsp-settings").common_on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = false
    end,
})
