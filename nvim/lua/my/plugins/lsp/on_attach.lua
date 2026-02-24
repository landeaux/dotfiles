---@param client vim.lsp.Client|nil
---@param bufnr integer
local function documentColor(client, bufnr)
    if client and client:supports_method("textDocument/documentColor", bufnr) then
        -- Wrap in pcall to prevent errors from vim.wait() triggering other plugin callbacks
        pcall(require("document-color").buf_attach, bufnr)
    end
end

---@param client vim.lsp.Client|nil
---@param bufnr integer
local function documentHighlight(client, bufnr)
    if client and client:supports_method("textDocument/documentHighlight", bufnr) then
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
            group = vim.api.nvim_create_augroup("_lsp_detach_document_highlight", { clear = true }),
            callback = function(event)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = highlight_augroup_name, buffer = event.buf })
            end,
        })
    end
end

local function codeLens(client, bufnr)
    if client and client:supports_method("textDocument/codeLens", bufnr) then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("_lsp_codelens", { clear = true }),
            callback = vim.lsp.codelens.refresh,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
        local bufnr = event.buf

        -- Skip invalid or scratch buffers
        if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
            return
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require("my.plugins.lsp.mappings").register(client, bufnr)
        documentColor(client, bufnr)
        documentHighlight(client, bufnr)
        codeLens(client, bufnr)
    end,
})
