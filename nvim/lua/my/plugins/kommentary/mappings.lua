local map = vim.keymap.set
local opts = { remap = true }

map("n", "<leader>/", "<Plug>kommentary_line_default", opts)
map("v", "<leader>/", "<Plug>kommentary_visual_default", opts)

local ok, wk = pcall(require, "which-key")
if ok then
    wk.register({
        ["/"] = "Toggle commenting level for line",
    }, { prefix = "<leader>" })

    wk.register({
        ["/"] = "Toggle commenting level",
    }, { mode = "v", prefix = "<leader>" })
end
