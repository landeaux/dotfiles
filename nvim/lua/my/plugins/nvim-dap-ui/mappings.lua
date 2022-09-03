vim.keymap.set("n", "<Leader>du", function()
    require("dapui").toggle({})
end, { silent = true })

require("which-key").register({
    d = {
        name = "+dap",
        u = "Toggle DAP UI",
    },
}, {
    prefix = "<leader>",
})
