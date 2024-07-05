return {
    {
        "neovim/nvim-lspconfig",
        config = function() require("my.plugins.lsp.config") end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "jose-elias-alvarez/typescript.nvim",
            "williamboman/mason-lspconfig.nvim",
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
