require'lspconfig'.bashls.setup {
    cmd = {vim.fn.stdpath("data") .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = require'config.lsp.nvim-lsp-settings'.common_on_attach,
    filetypes = { "sh", "zsh" }
}