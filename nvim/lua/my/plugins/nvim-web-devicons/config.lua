require("nvim-web-devicons").setup({
    override = {
        snap = { icon = "󰄀", color = "#7eca9c", name = "snap" },
        tar = { icon = "󰀼", color = "#ebcb8b", name = "tar" },
    },
    override_by_extension = {
        ["tpl"] = {
            icon = "",
            color = "#ffbf00",
            name = "Smarty",
        },
    },
})
