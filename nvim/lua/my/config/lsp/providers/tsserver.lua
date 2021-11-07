-- npm install -g typescript typescript-language-server
return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    settings = { documentFormatting = false },
    on_attach = function(client, bufnr)
        require("my.config.lsp.providers.defaults").on_attach(client, bufnr)

        client.resolved_capabilities.document_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup({
            -- debug = true,
            enable_import_on_completion = true,
            import_all_timeout = 5000, -- ms

            -- update imports on file move
            update_imports_on_move = true,
            require_confirmation_on_move = false,
        })

        -- required to fix code action ranges
        ts_utils.setup_client(client)

        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<Leader>lo",
            ":TSLspOrganize<CR>",
            { silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<Leader>lR",
            ":TSLspRenameFile<CR>",
            { silent = true }
        )
        vim.api.nvim_buf_set_keymap(
            bufnr,
            "n",
            "<Leader>li",
            ":TSLspImportAll<CR>",
            { silent = true }
        )

        local keymap_leader = {
            l = {
                name = "+lsp",
                o = "Organize imports",
                -- x = "Fix current problem",
                R = "Rename file and update imports",
                i = "Import all missing imports",
            },
        }

        local wk = require("whichkey_setup")
        wk.register_keymap("leader", keymap_leader)
    end,
}
