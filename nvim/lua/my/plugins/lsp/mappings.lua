local map_factory = require("my.utils").map_factory

local M = {}

local allowed_to_format = {
    "dockerls",
    "prismals",
    "null-ls",
    "taplo",
    -- "jsonls",
    -- "tsserver",
    -- "vuels",
}

local function format()
    vim.lsp.buf.format({
        async = true,
        filter = function(client)
            return client.server_capabilities.documentFormattingProvider
                and vim.tbl_contains(allowed_to_format, client.name)
        end,
    })
end

M.register = function(_, bufnr)
    local map = map_factory({ buffer = bufnr, silent = true })
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
    map("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
    map({ "n", "x" }, "<Leader>lc", vim.lsp.buf.code_action, { desc = "Show code actions" })
    map("n", "<Leader>lf", format, { desc = "Format" })
    map("n", "<Leader>li", ":LspInfo<CR>", { desc = "Show LSP info" })
end

return M
