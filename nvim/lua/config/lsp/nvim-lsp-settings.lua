vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
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

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)

    buf_set_keymap('n', '<C-k>', ':Lspsaga signature_help<CR>', opts)
    buf_set_keymap('n', '<Leader>lp', ':Lspsaga preview_definition<CR>', opts)
    buf_set_keymap('n', '<Leader>lr', ':Lspsaga rename<CR>', opts)
    buf_set_keymap('n', '<Leader>lc', ':Lspsaga code_action<CR>', opts)

    buf_set_keymap('n', '<Leader>ldk', ':Lspsaga show_cursor_diagnostics<CR>', opts)
    buf_set_keymap('n', '<Leader>lds', ':Lspsaga show_line_diagnostics<CR>', opts)
    buf_set_keymap('n', '<Leader>ldp', ':Lspsaga diagnostic_jump_prev<CR>', opts)
    buf_set_keymap('n', '<Leader>ldn', ':Lspsaga diagnostic_jump_next<CR>', opts)

    buf_set_keymap('n', '<Leader>lwa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>lwr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<Leader>lwl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_set_keymap('n', '<Leader>lI', ':LspInfo<CR>', opts)

    -- scroll down hover doc or scroll in definition preview
    buf_set_keymap('n', '<C-f>', ":lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
    -- scroll up hover doc
    buf_set_keymap('n', '<C-b>', ":lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)

    vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

    local function buf_bind_picker(...)
        require('config.tools.telescope-nvim-utils').buf_bind_picker(bufnr, ...)
    end

    -- Telescope LSP
    buf_bind_picker('<Leader>lsd', 'lsp_document_symbols')
    buf_bind_picker('<Leader>lsw', 'lsp_workspace_symbols')
    buf_bind_picker('<Leader>ldd', 'lsp_document_diagnostics')
    buf_bind_picker('<Leader>ldw', 'lsp_workspace_diagnostics')
    buf_bind_picker('<Leader>lad', 'lsp_code_actions')

    local keys = {
        l = {
            name = '+lsp',
            a = {
                name = '+code-actions',
                d = 'Document Actions'
            },
            s = {
                name = '+symbols',
                d = 'Document Symbols',
                w = 'Workspace Symbols'
            },
            d = {
                name = '+diagnostics',
                k = 'Show cursor diagnostics',
                s = 'Show line diagnostics',
                p = 'Goto prev',
                n = 'Goto next',
                d = 'Document Diagnostics',
                w = 'Workspace Diagnostics'
            },
            c = 'Code Actions',
            w = {
                name = '+workspace',
                a = 'Add workspace folder',
                r = 'Remove workspace folder',
                l = 'List workspace folders'
            },
            r = 'Rename',
            p = 'Preview definition',
            I = 'LSP Info'
        }
    }

    require('whichkey_setup').register_keymap('leader', keys)

    documentHighlight(client, bufnr)

    -- LSP Signatures
    require('lsp_signature').on_attach()
end

function lsp_config.tsserver_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

function lsp_config.vuels_on_attach(client, bufnr)
    lsp_config.common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = {"pyright", "tsserver"}
-- for _, lsp in ipairs(servers) do nvim_lsp[lsp].setup {on_attach = on_attach} end
return lsp_config
