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
        clients = { "ruff" },
    },
    code_lenses = true,
})

vim.fn.sign_define("LightBulbSign", { text = icon })
vim.cmd("highlight LightBulbFloatWin guifg=#f9e2af")
vim.cmd("highlight LightBulbVirtualText guifg=#f9e2af")
