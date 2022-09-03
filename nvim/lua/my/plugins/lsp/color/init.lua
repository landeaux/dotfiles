local M = {}

function M.document_color(client)
    local params = {
        textDocument = vim.lsp.util.make_text_document_params(),
    }
    -- vim.lsp.buf_request(0, "textDocument/documentColor", params)
    client.request("textDocument/documentColor", params, nil, 0)
end

M.on_document_color = require("my.plugins.lsp.color.utils").on_document_color

return M
