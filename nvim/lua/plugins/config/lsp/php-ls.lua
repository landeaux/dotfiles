-- npm i -g intelephense
require("lspconfig").intelephense.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/php/node_modules/.bin/intelephense",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 1500,
    },
    capabilities = require("plugins.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = require("plugins.config.lsp.nvim-lsp-settings").common_on_attach,
})
