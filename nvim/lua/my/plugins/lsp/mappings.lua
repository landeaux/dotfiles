local map_factory = require("my.utils").map_factory

local M = {}

---@param client vim.lsp.Client|nil
---@param bufnr integer
M.register = function(client, bufnr)
    local map = map_factory({ buffer = bufnr, silent = true })
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "grd", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "<Leader>li", ":lsp<CR>", { desc = "Show LSP info" })

    if client and client:supports_method("textDocument/inlayHint", bufnr) and vim.lsp.inlay_hint then
        map("n", "<leader>tI", function()
            ---@diagnostic disable-next-line: missing-parameter
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle Inlay Hints" })
    end

    map(
        "n",
        "<leader>td",
        function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
        { desc = "Toggle Diagnostics" }
    )
end

return M
