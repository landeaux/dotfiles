require("lspconfig").bashls.setup({
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
        "start",
    },
    filetypes = { "sh", "zsh" },
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = require("plugins.config.lsp.nvim-lsp-settings").capabilities,
    on_attach = require("plugins.config.lsp.nvim-lsp-settings").common_on_attach,
})
