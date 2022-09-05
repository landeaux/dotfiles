require("which-key").setup({
    plugins = {
        marks = false,
        registers = false,
        spelling = {
            enabled = true,
            suggestions = 9,
        },
    },
})

vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
