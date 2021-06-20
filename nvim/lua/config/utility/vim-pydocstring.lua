local bind = vim.api.nvim_set_keymap
local wk = require('whichkey_setup')

local formatter = "numpy"
vim.g.pydocstring_doq_path = "~/.pyenv/versions/doq/bin/doq"
vim.g.pydocstring_templates_path = "~/.config/nvim/plug-config/vim-pydocstring/templates" .. "/" .. formatter
vim.g.pydocstring_formatter = formatter

bind('n', '<leader>pl', '<Plug>(pydocstring)', {silent = true})
bind('n', '<leader>pf', ':PydocstringFormat<CR>', {silent = true})
bind('v', '<leader>p', ":'<,'>Pydocstring<CR>", {silent = true})

wk.register_keymap(
    'leader', {
        p = {
            name = '+pydocstring',
            l = 'Add docstring to function or class under the cursor',
            f = 'Add docstrings to all functions and classes in the file'
        }
    }
)

wk.register_keymap(
    'leader', {
        p = 'Add python docstring to the function or class inside visual selection',
    },
    {mode = 'v'}
)
