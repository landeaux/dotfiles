require("my.plugins.lsp.providers")
require("my.plugins.lsp.diagnostics")
require("my.plugins.lsp.nvim-lightbulb")

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded" }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
