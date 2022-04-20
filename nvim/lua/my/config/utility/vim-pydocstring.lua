local bind = vim.api.nvim_set_keymap
local wk = require("which-key")

local formatter = "numpy"
vim.g.pydocstring_doq_path = vim.fn.getenv("PYENV_ROOT") .. "/versions/doq/bin/doq"
vim.g.pydocstring_templates_path = vim.fn.stdpath("config")
    .. "/plug-config/vim-pydocstring/templates/"
    .. formatter
vim.g.pydocstring_formatter = formatter

local opts = { silent = true }
bind("n", "<leader>pl", "<Plug>(pydocstring)", opts)
bind("n", "<leader>pf", ":PydocstringFormat<CR>", opts)
bind("v", "<leader>p", ":'<,'>Pydocstring<CR>", opts)

wk.register({
    p = {
        name = "+pydocstring",
        l = "Add docstring to function or class under the cursor",
        f = "Add docstrings to all functions and classes in the file",
    },
}, {
    prefix = "<leader>",
})

wk.register({
    p = "Add python docstring to the function or class inside visual selection",
}, {
    mode = "v",
    prefix = "<leader>",
})
