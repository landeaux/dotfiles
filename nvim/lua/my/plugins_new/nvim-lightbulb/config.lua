require("nvim-lightbulb").update_lightbulb({
    sign = {
        enabled = true,
        priority = 20,
    },
    float = {
        enabled = true,
        text = "",
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
        text = "",
    },
})

vim.fn.sign_define("LightBulbSign", { text = "" })

require("my.utils").create_augroup({
    {
        event = "CursorHold,CursorHoldI",
        opts = { pattern = "*", command = 'lua require("nvim-lightbulb").update_lightbulb()' },
    },
}, "_nvim_lightbulb")
