local M = {}
local wk = require("which-key")
local create_augroup = require("my.utils").create_augroup

local format_on_save = false
local auto_format_lock = false

local function documentColor(client, bufnr)
    if vim.tbl_contains(vim.tbl_keys(client.handlers), "textDocument/documentColor") then
        require("my.config.lsp.color").document_color(client)
        create_augroup({
            {
                event = { "BufEnter", "TextChanged", "InsertLeave" },
                opts = {
                    buffer = bufnr,
                    callback = function()
                        require("my.config.lsp.color").document_color(client)
                    end,
                },
            },
        }, "_lsp_document_color")
    end
end

local function documentHighlight(client, bufnr)
    if client.resolved_capabilities.document_highlight then
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

local allowed_to_format = {
    "dockerls",
    "null-ls",
    "taplo",
    -- "jsonls",
    -- "tsserver",
    -- "vuels",
}

function M.on_attach(client, bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr, silent = true }

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    if
        client.resolved_capabilities.document_formatting
        and vim.tbl_contains(allowed_to_format, client.name)
    then
        if format_on_save and not auto_format_lock then
            auto_format_lock = true -- just run autocommand once
            -- Format on save
            require("my.utils").create_augroup({
                {
                    event = "BufWritePre",
                    opts = {
                        pattern = "*",
                        callback = function()
                            vim.lsp.buf.formatting_sync(nil, 1000)
                        end,
                    },
                },
            }, "_lsp_auto_format")
        end

        map("n", "<Leader>lf", vim.lsp.buf.formatting, opts)
        wk.register({ l = { name = "+lsp", f = "Format" } }, { prefix = "<leader>" })
    else
        client.resolved_capabilities.document_formatting = false
    end

    -- Mappings
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gy", vim.lsp.buf.type_definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gI", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)

    map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    map("n", "<Leader>lr", vim.lsp.buf.rename, opts)
    map("n", "<Leader>lc", vim.lsp.buf.code_action, opts)
    map("x", "<Leader>lc", vim.lsp.buf.range_code_action, opts)

    map("n", "<Leader>ldk", function()
        vim.diagnostic.open_float(0, { scope = "cursor" })
    end, opts)
    map("n", "<Leader>lds", vim.diagnostic.open_float, opts)
    map("n", "<Leader>ldq", vim.diagnostic.setloclist, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)

    map("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, opts)
    map("n", "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, opts)
    map("n", "<Leader>lwl", function()
        vim.notify(
            vim.lsp.buf.list_workspace_folders(),
            "info",
            { title = "Workspace Folders", hide_from_history = true }
        )
    end, opts)

    map("n", "<Leader>lI", ":LspInfo<CR>", opts)

    -- Telescope LSP
    map("n", "<Leader>lsd", ":Telescope lsp_document_symbols<CR>", opts)
    map("n", "<Leader>lsw", ":Telescope lsp_workspace_symbols<CR>", opts)
    map("n", "<Leader>lad", ":Telescope lsp_code_actions<CR>", opts)

    local keymap_leader = {
        l = {
            name = "+lsp",
            a = { name = "+code-actions", d = "Document Actions" },
            s = { name = "+symbols", d = "Document Symbols", w = "Workspace Symbols" },
            d = {
                name = "+diagnostics",
                k = "Show cursor diagnostics",
                s = "Show line diagnostics",
                p = "Goto prev",
                q = "Set loclist",
                n = "Goto next",
            },
            c = "Code Actions",
            w = {
                name = "+workspace",
                a = "Add workspace folder",
                r = "Remove workspace folder",
                l = "List workspace folders",
            },
            r = "Rename",
            I = "LSP Info",
        },
    }

    local keymap_g = {
        name = "+goto",
        D = "Go to declaration",
        I = "Go to implementation",
        d = "Go to definition",
        r = "Go to references",
        y = "Go to type definition",
    }

    wk.register(keymap_leader, { prefix = "<leader>" })
    wk.register(keymap_g, { prefix = "g" })

    documentColor(client, bufnr)
    documentHighlight(client, bufnr)
    codeLens(client, bufnr)
end

M.flags = {
    debounce_text_changes = 150,
}

M.capabilities = vim.tbl_deep_extend("keep", {
    textDocument = {
        documentColor = { dynamicRegistration = true },
    },
}, require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()))

M.root_dir = function(fname)
    local util = require("lspconfig").util
    return util.root_pattern(".git")(fname)
        or util.root_pattern("tsconfig.base.json")(fname)
        or util.root_pattern("package.json")(fname)
        or util.root_pattern(".eslintrc.js")(fname)
        or util.root_pattern("tsconfig.json")(fname)
        or vim.loop.cwd()
end

M.autostart = true

return M
