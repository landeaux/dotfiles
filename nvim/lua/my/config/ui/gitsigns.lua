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
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
    on_attach = function(bufnr)
        local default_opts = { buffer = bufnr, silent = true }

        local function map(mode, l, r, opts)
            opts = opts or {}
            local merged_opts = vim.tbl_deep_extend("force", opts, default_opts)
            vim.keymap.set(mode, l, r, merged_opts)
        end

        -- Navigation
        map("n", "]h", "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", { expr = true })
        map("n", "[h", "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map("n", "<leader>hb", function()
            require("gitsigns").blame_line({ full = true })
        end)
        map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>")
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>")
        map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>")
        map("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>")
        map("n", "<leader>td", ":Gitsigns toggle_deleted<CR>")

        -- Text object
        map({ "o", "x" }, "ih", ":Gitsigns select_hunk<CR>")

        local wk = require("which-key")

        wk.register({
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
                d = "Deleted lines",
            },
        }, {
            prefix = "<leader>",
        })

        wk.register({
            h = {
                name = "+hunk",
                r = "Reset hunk",
                s = "Stage hunk",
            },
        }, {
            prefix = "<leader>",
            mode = "v",
        })
    end,
})
