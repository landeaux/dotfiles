require("lspconfig").html.setup({
    cmd = {
        "node",
        vim.fn.stdpath("data")
            .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("my.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = require("my.config.lsp.nvim-lsp-settings").common_on_attach,
})