return {
    {
        "neovim/nvim-lspconfig",
        config = function() require("my.plugins.lsp.config") end,
        dependencies = {
            "blink.cmp",
            "jose-elias-alvarez/typescript.nvim",
            "b0o/schemastore.nvim", -- for jsonls
            {
                "mrshmllow/document-color.nvim",
                config = function()
                    require("document-color").setup({
                        mode = "background", -- "background" | "foreground" | "single"
                    })
                end,
            },
        },
    },
}
