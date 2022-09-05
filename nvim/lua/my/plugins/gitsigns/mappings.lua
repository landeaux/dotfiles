local M = {}

M.register = function(bufnr)
    local default_opts = { buffer = bufnr, silent = true }

    local function map(mode, l, r, opts)
        opts = opts or {}
        local merged_opts = vim.tbl_deep_extend("force", opts, default_opts)
        vim.keymap.set(mode, l, r, merged_opts)
    end

    -- Navigation
    map("n", "]h", "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", { expr = true, desc = "Next hunk" })
    map(
        "n",
        "[h",
        "&diff ? '[c' : ':Gitsigns prev_hunk<CR>'",
        { expr = true, desc = "Previous hunk" }
    )

    -- Actions
    map("n", "<leader>hb", function()
        require("gitsigns").blame_line({ full = true })
    end, { desc = "Show git blame per line" })
    map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    map("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", { desc = "Reset all hunks in buffer" })
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
    map("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
    map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
    map(
        "n",
        "<leader>tb",
        ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "Toggle current line blame" }
    )
    map("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", { desc = "Toggle deleted lines" })

    -- Text object
    map({ "o", "x" }, "ih", ":Gitsigns select_hunk<CR>", { desc = "Inner hunk" })

    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register({ h = { name = "+hunk" } }, { prefix = "<leader>" })
        wk.register({ h = { name = "+hunk" } }, { prefix = "<leader>", mode = "v" })
    end
end

return M
