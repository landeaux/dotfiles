local M = {}
local wk = require("whichkey_setup")

local format_on_save = false
local auto_format_lock = false

local function documentHighlight(client, _)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
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
    local opts = { noremap = true, silent = true }

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

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
                        command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
                    },
                },
            }, "_lsp_auto_format")
        end

        buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        wk.register_keymap("leader", { l = { name = "+lsp", f = "Format" } })
    else
        client.resolved_capabilities.document_formatting = false
    end

    -- Mappings.
    buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gI", ":lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)

    buf_set_keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<Leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<Leader>lc", ":lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("x", "<Leader>lc", ":lua vim.lsp.buf.range_code_action()<CR>", opts)

    buf_set_keymap(
        "n",
        "<Leader>ldk",
        ':lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>',
        opts
    )
    buf_set_keymap("n", "<Leader>lds", ":lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "<Leader>ldq", ":lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)

    buf_set_keymap("n", "<Leader>lwa", ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<Leader>lwr", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap(
        "n",
        "<Leader>lwl",
        ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )

    buf_set_keymap("n", "<Leader>lI", ":LspInfo<CR>", opts)

    -- Telescope LSP
    buf_set_keymap("n", "<Leader>lsd", ":Telescope lsp_document_symbols<CR>", opts)
    buf_set_keymap("n", "<Leader>lsw", ":Telescope lsp_workspace_symbols<CR>", opts)
    buf_set_keymap("n", "<Leader>lad", ":Telescope lsp_code_actions<CR>", opts)

    -- TODO: Move these to telescope config now that diagnostics have been abstracted away from LSP
    buf_set_keymap("n", "<Leader>ldd", ":Telescope diagnostics bufnr=0<CR>", opts)
    buf_set_keymap("n", "<Leader>ldw", ":Telescope diagnostics<CR>", opts)

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
                d = "Document Diagnostics",
                w = "Workspace Diagnostics",
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

    wk.register_keymap("leader", keymap_leader)
    wk.register_keymap("g", keymap_g)

    documentHighlight(client, bufnr)
end

M.flags = {
    debounce_text_changes = 150,
}

M.capabilities = require("cmp_nvim_lsp").update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

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
