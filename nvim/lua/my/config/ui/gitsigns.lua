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
    on_attach = function(bufnr)
        local default_opts = { noremap = true }

        local function map(mode, l, r, opts)
            opts = opts or {}
            local merged_opts = vim.tbl_deep_extend("force", opts, default_opts)
            vim.api.nvim_buf_set_keymap(bufnr, mode, l, r, merged_opts)
        end

        -- Navigation
        map("n", "]h", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
        map("n", "[h", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map("n", "<leader>hb", "<cmd>Gitsigns blame_line true<CR>")
        map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
        map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
        map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
        map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
        map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
        map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
        map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
        map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
        map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")

        -- Text object
        map("o", "ih", "<cmd>Gitsigns select_hunk<CR>")
        map("x", "ih", "<cmd>Gitsigns select_hunk<CR>")

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
    end,
})
