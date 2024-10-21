local icon = "󰌵"

require("nvim-lightbulb").setup({
    sign = {
        enabled = false,
    },
    virtual_text = {
        enabled = true,
        text = icon,
        hl_mode = "combine",
    },
    autocmd = {
        enabled = true,
        updatetime = -1,
    },
    ignore = {
        clients = { "ruff_lsp" },
    },
    code_lenses = true,
})

vim.fn.sign_define("LightBulbSign", { text = icon })
vim.api.nvim_command("highlight LightBulbFloatWin guifg=#f9e2af")
vim.api.nvim_command("highlight LightBulbVirtualText guifg=#f9e2af")
