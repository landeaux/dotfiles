local M = {}

local create_augroup = require("my.utils").create_augroup

local function documentColor(client, bufnr)
    if client.server_capabilities.colorProvider then
        require("document-color").buf_attach(bufnr)
    end
end

-- local function documentColor(client, bufnr)
--     if vim.tbl_contains(vim.tbl_keys(client.handlers), "textDocument/documentColor") then
--         require("my.plugins.lsp.color").document_color(client)
--         create_augroup({
--             {
--                 event = { "BufEnter", "TextChanged", "InsertLeave" },
--                 opts = {
--                     buffer = bufnr,
--                     callback = function()
--                         require("my.plugins.lsp.color").document_color(client)
--                     end,
--                 },
--             },
--         }, "_lsp_document_color")
--     end
-- end

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
        create_augroup({
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

function M.on_attach(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    require("my.plugins.lsp.mappings").register(client, bufnr)
    documentColor(client, bufnr)
    documentHighlight(client, bufnr)
    codeLens(client, bufnr)
end

M.flags = {
    debounce_text_changes = 150,
}

M.capabilities =
    require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
M.capabilities.textDocument.colorProvider = {
    dynamicRegistration = true,
}

-- M.capabilities = vim.tbl_deep_extend("keep", {
--     textDocument = {
--         documentColor = { dynamicRegistration = true },
--     },
-- }, require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()))

-- M.root_dir = function(fname)
--     local util = require("lspconfig").util
--     return util.root_pattern(".git")(fname)
--         or util.root_pattern("tsconfig.base.json")(fname)
--         or util.root_pattern("package.json")(fname)
--         or util.root_pattern(".eslintrc.js")(fname)
--         or util.root_pattern("tsconfig.json")(fname)
--         or vim.loop.cwd()
-- end

M.autostart = true

return M
