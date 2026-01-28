return {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
        -- Explorer panel configuration
        explorer = {
            initial_focus = "modified", -- Initial focus: "explorer", "original", or "modified"
        },
    },
}
