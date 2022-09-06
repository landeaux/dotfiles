local which_key_ok, wk = pcall(require, "which-key")
local map_factory = require("my.utils").map_factory

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
    local map = map_factory({ buffer = bufnr, silent = true })

    if
        client.resolved_capabilities.document_formatting
        and vim.tbl_contains(allowed_to_format, client.name)
    then
        map("n", "<Leader>lf", vim.lsp.buf.formatting, { desc = "Format" })

        if which_key_ok then
            wk.register({ l = { name = "+lsp" } }, { prefix = "<leader>" })
        end
    end

    -- Mappings
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    map("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
    map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
    map("n", "<Leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
    map("n", "<Leader>lc", vim.lsp.buf.code_action, { desc = "Show code actions" })
    map("x", "<Leader>lc", vim.lsp.buf.range_code_action, { desc = "Show code actions" })
    map("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
    map(
        "n",
        "<Leader>lwr",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "Remove workspace folder" }
    )
    map("n", "<Leader>lwl", function()
        vim.notify(
            vim.lsp.buf.list_workspace_folders(),
            "info",
            { title = "Workspace Folders", hide_from_history = true }
        )
    end, { desc = "List workspace folders" })
    map("n", "<Leader>lI", ":LspInfo<CR>", { desc = "Show LSP info" })

    -- Telescope LSP
    map(
        "n",
        "<Leader>lsd",
        ":Telescope lsp_document_symbols<CR>",
        { desc = "Find document symbols" }
    )
    map(
        "n",
        "<Leader>lsw",
        ":Telescope lsp_workspace_symbols<CR>",
        { desc = "Find workspace symbols" }
    )

    if which_key_ok then
        wk.register({
            l = {
                name = "+lsp",
                s = { name = "+symbols" },
                w = { name = "+workspace" },
            },
        }, { prefix = "<leader>" })
    end
end

return M
