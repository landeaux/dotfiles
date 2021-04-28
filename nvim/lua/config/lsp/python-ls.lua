require'lspconfig'.pyright.setup {
    cmd = {vim.fn.stdpath('data') .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio"},
    on_attach = require'config.lsp.nvim-lsp-settings'.common_on_attach,
}
