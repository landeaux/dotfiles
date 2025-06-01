require("FTerm").setup({
    border = vim.o.winborder,
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

require("my.plugins.fterm.commands")
require("my.plugins.fterm.mappings")
