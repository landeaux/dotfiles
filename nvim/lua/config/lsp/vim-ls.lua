require'lspconfig'.vimls.setup {
    cmd = {
        vim.fn.stdpath("data") .. "/lspinstall/vim/node_modules/.bin/vim-language-server",
        "--stdio"
    },
    on_attach = require'config.lsp.nvim-lsp-settings'.common_on_attach
}
