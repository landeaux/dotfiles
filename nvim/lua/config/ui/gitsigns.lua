local bind = vim.api.nvim_set_keymap

require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },
    numhl = false,
    linehl = false,
    watch_index = { interval = 1000 },
    current_line_blame = false,
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_internal_diff = true, -- If luajit is present
})

-- Default keymap options
local opts = { noremap = true }

bind(
    "n",
    "]h",
    "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
    { noremap = true, expr = true }
)
bind(
    "n",
    "[h",
    "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
    { noremap = true, expr = true }
)

bind(
    "n",
    "<leader>ghn",
    "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
    { noremap = true, expr = true }
)
bind(
    "n",
    "<leader>ghp",
    "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
    { noremap = true, expr = true }
)

bind("n", "<leader>ghs", '<cmd>lua require"gitsigns".stage_hunk()<CR>', opts)
bind("n", "<leader>ghu", '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', opts)
bind("n", "<leader>ghr", '<cmd>lua require"gitsigns".reset_hunk()<CR>', opts)
bind("n", "<leader>ghv", '<cmd>lua require"gitsigns".preview_hunk()<CR>', opts)
bind("n", "<leader>ghb", '<cmd>lua require"gitsigns".blame_line()<CR>', opts)

local keys = {
    g = {
        h = {
            name = "+hunk",
            n = "Next hunk",
            p = "Previous hunk",
            s = "Stage hunk",
            u = "Undo hunk",
            v = "Preview hunk",
            r = "Reset hunk",
            b = "Blame line",
        },
    },
}

require("whichkey_setup").register_keymap("leader", keys)
