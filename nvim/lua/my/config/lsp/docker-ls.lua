require("lspconfig").dockerls.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
        "--stdio",
    },
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = vim.loop.cwd,
    capabilities = require("my.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = require("my.config.lsp.nvim-lsp-settings").common_on_attach,
})