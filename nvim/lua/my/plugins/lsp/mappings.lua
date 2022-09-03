local wk = require("which-key")

local M = {}

local allowed_to_format = {
    "dockerls",
    "null-ls",
    "taplo",
    -- "jsonls",
    -- "tsserver",
    -- "vuels",
}

M.register = function(client, bufnr)
    local map = vim.keymap.set
    local opts = { buffer = bufnr, silent = true }

    if
        client.resolved_capabilities.document_formatting
        and vim.tbl_contains(allowed_to_format, client.name)
    then
        map("n", "<Leader>lf", vim.lsp.buf.formatting, opts)
        wk.register({ l = { name = "+lsp", f = "Format" } }, { prefix = "<leader>" })
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
end

return M
