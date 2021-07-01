-- npm install -g typescript typescript-language-server
-- require'snippets'.use_suggested_mappings()
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
-- local on_attach_common = function(client)
-- print("LSP Initialized")
-- require'completion'.on_attach(client)
-- require'illuminate'.on_attach(client)
-- end
require("lspconfig").tsserver.setup({
    cmd = {
        vim.fn.stdpath("data")
            .. "/lspinstall/typescript/node_modules/.bin/typescript-language-server",
        "--stdio",
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").tsserver_on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = require("lspconfig/util").root_pattern(
        "package.json",
        "tsconfig.json",
        "jsconfig.json",
        ".git"
    ),
    settings = { documentFormatting = false },
})
