local map = vim.keymap.set

map(
    "n",
    "<leader>/",
    "<Plug>kommentary_line_default",
    { silent = true, remap = true, desc = "Comment/uncomment line" }
)
map(
    "v",
    "<leader>/",
    "<Plug>kommentary_visual_default",
    { silent = true, remap = true, desc = "Comment/uncomment visual selection" }
)
