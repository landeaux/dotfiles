require("lspconfig").jsonls.setup({
    cmd = {
        "node",
        vim.fn.stdpath("data")
            .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("plugins.config.lsp.nvim-lsp-settings").capabilities,
    commands = {
        Format = {
            function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end,
        },
    },
    on_attach = require("plugins.config.lsp.nvim-lsp-settings").common_on_attach,
})
