local text = "▌" -- "|", "▏", "▌", "│", "┃"

require("gitsigns").setup({
    signs = {
        add = {
            text = text,
        },
        change = {
            text = text,
        },
        delete = {
            text = text,
        },
        topdelete = {
            text = text,
        },
        changedelete = {
            text = text,
        },
        untracked = {
            text = text,
        },
    },
    preview_config = {
        border = "rounded",
    },
    on_attach = function(bufnr)
        require("my.plugins.gitsigns.mappings").register(bufnr)
    end,
})
