local map_factory = require("my.utils").map_factory

local M = {}

-- local allowed_to_format = {
--     "dockerls",
--     "prismals",
--     "taplo",
--     -- "jsonls",
--     -- "ts_ls",
--     -- "vuels",
-- }

-- local function format()
--     vim.lsp.buf.format({
--         async = true,
--         filter = function(client)
--             return client.server_capabilities.documentFormattingProvider
--                 and vim.tbl_contains(allowed_to_format, client.name)
--         end,
--     })
-- end

---@param client vim.lsp.Client|nil
---@param bufnr integer
M.register = function(client, bufnr)
    local map = map_factory({ buffer = bufnr, silent = true })
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    -- map("n", "grt", vim.lsp.buf.type_definition, { desc = "Go to type definition" }) -- already set as default
    map("n", "grd", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    -- map("n", dgI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    -- map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" }) -- default is now "grr"
    -- map("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" }) -- already set as default
    -- map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" }) -- now available in insert mode as "<C-s>"
    -- map("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" }) -- default is now "grn"
    -- map({ "n", "x" }, "<Leader>lc", vim.lsp.buf.code_action, { desc = "Show code actions" }) -- default is now "gra"
    -- map("n", "<Leader>lf", format, { desc = "Format" })
    map("n", "<Leader>li", ":LspInfo<CR>", { desc = "Show LSP info" })

    if client and client:supports_method("textDocument/inlayHint", bufnr) and vim.lsp.inlay_hint then
        map("n", "<leader>tI", function()
            ---@diagnostic disable-next-line: missing-parameter
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle Inlay Hints" })
    end

    map("n", "<leader>td", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, { desc = "Toggle Diagnostics" })
end

return M
