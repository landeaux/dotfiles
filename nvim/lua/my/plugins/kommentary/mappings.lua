local map = vim.keymap.set
local opts = { remap = true }

map("n", "<leader>/", "<Plug>kommentary_line_default", opts)
map("n", "<leader>cct", "<Plug>kommentary_line_default", opts)
map("n", "<leader>cci", "<Plug>kommentary_line_increase", opts)
map("n", "<leader>ccd", "<Plug>kommentary_line_decrease", opts)

map("n", "<leader>ct", "<Plug>kommentary_motion_default", opts)
map("n", "<leader>ci", "<Plug>kommentary_motion_increase", opts)
map("n", "<leader>cd", "<Plug>kommentary_motion_decrease", opts)

map("v", "<leader>/", "<Plug>kommentary_visual_default", opts)
map("v", "<leader>ct", "<Plug>kommentary_visual_default", opts)
map("v", "<leader>ci", "<Plug>kommentary_visual_increase", opts)
map("v", "<leader>cd", "<Plug>kommentary_visual_decrease", opts)

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
