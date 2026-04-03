require("codediff").setup({
    explorer = {
        initial_focus = "modified",
    },
    diff = {
        layout = "inline",
    },
})

require("my.plugins.codediff.mappings")
