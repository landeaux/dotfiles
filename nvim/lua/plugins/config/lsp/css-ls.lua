require("lspconfig").cssls.setup({
    cmd = {
        "node",
        vim.fn.stdpath("data")
            .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 150,
    },
    on_attach = require("plugins.config.lsp.nvim-lsp-settings").common_on_attach,
    capabilities = require("plugins.config.lsp.nvim-lsp-settings").capabilities,
})
