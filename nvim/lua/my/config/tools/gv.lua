local bind = vim.api.nvim_set_keymap

bind("n", "<Space>gvc", ":GV!<CR>", {})
bind("n", "<Space>gvl", ":GV?<CR>", {})
bind("n", "<Space>gvo", ":GV<CR>", {})

local keys = {
    g = {
        name = "+git",
        v = {
            name = "+commit-browser",
            c = "List commits that affected current file",
            l = "Fill location list with revisions of current file",
            o = "Open commit browser",
        },
    },
}

require("which-key").register(keys, { prefix = "<leader>" })
