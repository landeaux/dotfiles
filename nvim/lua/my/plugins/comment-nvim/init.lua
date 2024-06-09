return {
    "numToStr/Comment.nvim",
    config = function() require("my.plugins.comment-nvim.config") end,
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
                vim.g.skip_ts_context_commentstring_module = true
            end,
        },
    },
}
