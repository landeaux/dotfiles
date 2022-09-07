local map = require("my.utils").map_factory({ remap = true, silent = true })

map("n", "<leader>/", "<Plug>kommentary_line_default", { desc = "Comment/uncomment line" })
map(
    "v",
    "<leader>/",
    "<Plug>kommentary_visual_default",
    { desc = "Comment/uncomment visual selection" }
)
