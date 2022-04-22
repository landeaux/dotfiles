require("which-key").setup({
    plugins = {
        registers = false,
        spelling = {
            enabled = true,
        },
    },
})

vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
