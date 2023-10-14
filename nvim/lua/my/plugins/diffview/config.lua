local actions = require("diffview.actions")

require("diffview").setup({
    enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
    keymaps = {
        view = {
            ["<leader>ge"] = actions.focus_files, -- Bring focus to the file panel
            ["<leader>tf"] = actions.toggle_files, -- Toggle the file panel.
        },
        file_panel = {
            ["<leader>ge"] = actions.focus_files,
            ["<leader>tf"] = actions.toggle_files,
        },
        file_history_panel = {
            ["<leader>ge"] = actions.focus_files,
            ["<leader>tf"] = actions.toggle_files,
        },
    },
})

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "DiffviewDiffBufRead",
    callback = function(_)
        vim.opt_local.relativenumber = false
    end,
    group = vim.api.nvim_create_augroup("_diffview", { clear = true }),
})
