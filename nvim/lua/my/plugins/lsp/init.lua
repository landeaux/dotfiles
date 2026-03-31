return {
    {
        "neovim/nvim-lspconfig",
        config = function() require("my.plugins.lsp.config") end,
        dependencies = {
            "blink.cmp",
            "b0o/schemastore.nvim", -- for jsonls
        },
    },
}
