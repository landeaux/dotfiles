-- npm install -g typescript typescript-language-server
return {
    settings = { documentFormatting = false },
    on_attach = function(client, bufnr)
        require("my.config.lsp.providers.defaults").on_attach(client, bufnr)

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = true,

            -- import all
            import_all_timeout = 5000, -- ms
            import_all_priorities = {
                buffers = 4, -- loaded buffer names
                buffer_content = 3, -- loaded buffer content
                local_files = 2, -- git files or files with relative path markers
                same_file = 1, -- add to existing import statement
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- eslint
            eslint_enable_code_actions = false,
            eslint_enable_disable_comments = false,
            eslint_bin = "eslint_d",
            eslint_enable_diagnostics = false,
            eslint_opts = {},

            -- formatting
            enable_formatting = false,
            formatter = "prettierd",
            formatter_opts = {},

            -- update imports on file move
            update_imports_on_move = true,
            require_confirmation_on_move = false,
            watch_dir = nil,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},
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
