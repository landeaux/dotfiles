require("lspconfig").dockerls.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver",
        "--stdio",
    },
    on_attach = require("config.lsp.nvim-lsp-settings").common_on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = vim.loop.cwd,
})
