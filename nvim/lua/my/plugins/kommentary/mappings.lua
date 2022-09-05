local map = vim.keymap.set

map("n", "<leader>/", "<Plug>kommentary_line_default")
map("n", "<leader>cct", "<Plug>kommentary_line_default")
map("n", "<leader>cci", "<Plug>kommentary_line_increase")
map("n", "<leader>ccd", "<Plug>kommentary_line_decrease")

map("n", "<leader>ct", "<Plug>kommentary_motion_default")
map("n", "<leader>ci", "<Plug>kommentary_motion_increase")
map("n", "<leader>cd", "<Plug>kommentary_motion_decrease")

map("v", "<leader>/", "<Plug>kommentary_visual_default")
map("v", "<leader>ct", "<Plug>kommentary_visual_default")
map("v", "<leader>ci", "<Plug>kommentary_visual_increase")
map("v", "<leader>cd", "<Plug>kommentary_visual_decrease")

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        ["/"] = "Toggle commenting level for line",
        c = {
            name = "+comment",
            i = "Increase commenting level for motion",
            d = "Decrease commenting level for motion",
            t = "Toggle commenting level for motion",
            c = {
                name = "+line",
                i = "Increase commenting level for line",
                d = "Decrease commenting level for line",
                t = "Toggle commenting level for line",
            },
        },
    }, {
        prefix = "<leader>",
    })

    wk.register({
        ["/"] = "Toggle commenting level",
        c = {
            name = "+comment",
            i = "Increase commenting level",
            d = "Decrease commenting level",
            t = "Toggle commenting level",
        },
    }, {
        mode = "v",
        prefix = "<leader>",
    })
end
