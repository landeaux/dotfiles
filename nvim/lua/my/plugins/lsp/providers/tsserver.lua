-- npm install -g typescript typescript-language-server
return {
    on_attach = function(client, bufnr)
        require("my.plugins.lsp.providers.defaults").on_attach(client, bufnr)

        local map = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        -- Commands from typescript.nvim (https://github.com/jose-elias-alvarez/typescript.nvim)
        map("n", "<Leader>lo", ":TypescriptOrganizeImports<CR>", opts)
        map("n", "<Leader>lR", ":TypescriptRenameFile<CR>", opts)
        map("n", "<Leader>li", ":TypescriptAddMissingImports<CR>", opts)
        map("n", "<Leader>lu", ":TypescriptRemoveUnused<CR>", opts)
        map("n", "<Leader>lx", ":TypescriptFixAll<CR>", opts)

        local ok, wk = pcall(require, "which-key")
        if ok then
            wk.register({
                l = {
                    name = "+lsp",
                    i = "Add all missing imports",
                    o = "Organize imports",
                    R = "Rename file and update imports",
                    u = "Remove unused variables",
                    x = "Fix all",
                },
            }, { prefix = "<leader>" })
        end
    end,
}
