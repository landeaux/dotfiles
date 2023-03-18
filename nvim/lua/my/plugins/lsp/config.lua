require("my.plugins.lsp.diagnostics")
require("my.plugins.lsp.providers")

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

local function documentColor(client, bufnr)
    if client.server_capabilities.colorProvider then
        require("document-color").buf_attach(bufnr)
    end
end

local function documentHighlight(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
                augroup _lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
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

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        require("my.plugins.lsp.mappings").register(client, bufnr)
        documentColor(client, bufnr)
        documentHighlight(client, bufnr)
        codeLens(client, bufnr)
    end,
})
