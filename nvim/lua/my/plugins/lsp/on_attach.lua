local function documentColor(client, bufnr)
    if client.server_capabilities.colorProvider then
        require("document-color").buf_attach(bufnr)
    end
end

local function documentHighlight(client, bufnr)
    if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup_name = "_lsp_document_highlight"
        local highlight_augroup = vim.api.nvim_create_augroup(highlight_augroup_name, { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("_lsp_detach", { clear = true }),
            callback = function(event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_augroup_name, buffer = event.buf })
            end,
        })
    end
end

local function codeLens(client, bufnr)
    if client.supports_method("textDocument/codeLens") then
        require("my.utils").create_augroup({
            {
                event = { "BufEnter", "TextChanged", "TextChangedI", "TextChangedP" },
                opts = {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.codelens.refresh()
                    end,
                },
            },
        }, "_lsp_codelens")
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        require("my.plugins.lsp.mappings").register(client, bufnr)
        documentColor(client, bufnr)
        documentHighlight(client, bufnr)
        codeLens(client, bufnr)
    end,
})
