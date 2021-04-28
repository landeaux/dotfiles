require'lspconfig'.vuels.setup {
    cmd = {vim.fn.stdpath("data") .. "/lspinstall/vue/node_modules/.bin/vls"},
	on_attach = require'config.lsp.nvim-lsp-settings'.vuels_on_attach,
}
