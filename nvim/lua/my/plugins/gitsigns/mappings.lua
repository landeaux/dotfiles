local M = {}

M.register = function(bufnr)
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
end

return M