return {
    "iamcco/markdown-preview.nvim",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    init = function()
        require("my.plugins_new.markdown-preview.mappings")
    end,
    config = function()
        require("my.plugins_new.markdown-preview.config")
    end,
    ft = "markdown",
}
