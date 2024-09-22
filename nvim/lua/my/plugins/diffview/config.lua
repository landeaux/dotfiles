local actions = require("diffview.actions")

require("diffview").setup({
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    -- file_panel = {
    --     win_config = {
    --         width = 75,
    --     },
    -- },
    hooks = {
        diff_buf_read = function(bufnr)
            vim.opt_local.relativenumber = false
            vim.opt_local.wrap = false
        end,
    },
    keymaps = {
        view = {
            ["gq"] = "<CMD>DiffviewClose<CR>", -- Close the view
            ["<leader>ge"] = actions.focus_files, -- Bring focus to the file panel
            ["<leader>tf"] = actions.toggle_files, -- Toggle the file panel.
        },
        file_panel = {
            ["gq"] = "<CMD>DiffviewClose<CR>",
            ["<leader>ge"] = actions.focus_files,
            ["<leader>tf"] = actions.toggle_files,
        },
        file_history_panel = {
            ["gq"] = "<CMD>DiffviewClose<CR>",
            ["<leader>ge"] = actions.focus_files,
            ["<leader>tf"] = actions.toggle_files,
        },
    },
})
