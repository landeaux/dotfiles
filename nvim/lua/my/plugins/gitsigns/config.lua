local text = "▌" -- "|", "▏", "▌", "│", "┃"
local text_staged = "▏" -- "|", "▏", "▌", "│", "┃"

require("gitsigns").setup({
    signs = {
        add = { text = text },
        change = { text = text },
        delete = { text = text },
        topdelete = { text = text },
        changedelete = { text = text },
        untracked = { text = text },
    },
    signs_staged = {
        add = { text = text_staged },
        change = { text = text_staged },
        delete = { text = text_staged },
        topdelete = { text = text_staged },
        changedelete = { text = text_staged },
        untracked = { text = text_staged },
    },
    attach_to_untracked = true,
    preview_config = {
        border = "rounded",
    },
    on_attach = function(bufnr) require("my.plugins.gitsigns.mappings").register(bufnr) end,
})
