require("lspconfig").yamlls.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("my.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = require("my.config.lsp.nvim-lsp-settings").common_on_attach,
})