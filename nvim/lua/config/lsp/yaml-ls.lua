require'lspconfig'.yamlls.setup {
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
        "--stdio"
    },
    on_attach = require'config.lsp.nvim-lsp-settings'.common_on_attach
}
