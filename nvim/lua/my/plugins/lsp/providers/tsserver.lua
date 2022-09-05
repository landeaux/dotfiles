-- npm install -g typescript typescript-language-server
return {
    on_attach = function(client, bufnr)
        require("my.plugins.lsp.providers.defaults").on_attach(client, bufnr)

        local map = vim.keymap.set
        local build_opts = function(desc)
            return {
                buffer = bufnr,
                silent = true,
                desc = desc,
            }
        end

        -- Commands from typescript.nvim (https://github.com/jose-elias-alvarez/typescript.nvim)
        map("n", "<Leader>lo", ":TypescriptOrganizeImports<CR>", build_opts("Organize imports"))
        map(
            "n",
            "<Leader>lR",
            ":TypescriptRenameFile<CR>",
            build_opts("Rename file and update imports")
        )
        map(
            "n",
            "<Leader>li",
            ":TypescriptAddMissingImports<CR>",
            build_opts("Add missing imports")
        )
        map("n", "<Leader>lu", ":TypescriptRemoveUnused<CR>", build_opts("Remove unused variables"))
        map("n", "<Leader>lx", ":TypescriptFixAll<CR>", build_opts("Fix all"))
    end,
}
