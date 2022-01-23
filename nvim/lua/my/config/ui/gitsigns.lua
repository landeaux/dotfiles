local bind = vim.api.nvim_set_keymap

require("gitsigns").setup({
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
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
    watch_gitdir = { interval = 1000 },
    current_line_blame = false,
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    diff_opts = {
        internal = true,
    },
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

bind("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line({full = true})<CR>', opts)
bind("n", "<leader>hp", '<cmd>lua require"gitsigns".preview_hunk()<CR>', opts)
bind("n", "<leader>hr", '<cmd>lua require"gitsigns".reset_hunk()<CR>', opts)
bind("v", "<leader>hr", '<cmd>lua require"gitsigns".reset_hunk()<CR>', opts)
bind("n", "<leader>hR", '<cmd>lua require"gitsigns".reset_buffer()<CR>', opts)
bind("n", "<leader>hs", '<cmd>lua require"gitsigns".stage_hunk()<CR>', opts)
bind("v", "<leader>hs", '<cmd>lua require"gitsigns".stage_hunk()<CR>', opts)
bind("n", "<leader>hS", '<cmd>lua require"gitsigns".stage_buffer()<CR>', opts)
bind("n", "<leader>hu", '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', opts)
bind("n", "<leader>tb", '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>', opts)
bind("n", "<leader>td", '<cmd>lua require"gitsigns".toggle_deleted()<CR>', opts)

bind("o", "ih", '<cmd>Gitsigns select_hunk<CR>', opts)
bind("x", "ih", '<cmd>Gitsigns select_hunk<CR>', opts)

local wk = require("whichkey_setup")

wk.register_keymap("leader", {
    h = {
        name = "+hunk",
        b = "Blame line",
        p = "Preview hunk",
        r = "Reset hunk",
        R = "Reset buffer",
        s = "Stage hunk",
        S = "Stage buffer",
        u = "Undo stage hunk",
    },
    t = {
        b = "Current line blame",
        d = "Deleted hunks",
    },
})

wk.register_keymap("visual", {
    h = {
        name = "+hunk",
        r = "Reset hunk",
        s = "Stage hunk",
    },
})
