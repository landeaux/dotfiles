local bind = vim.api.nvim_set_keymap
local set_opt = require('utils').set_opt
local wk = require('whichkey_setup')

vim.g.pydocstring_doq_path = "~/.pyenv/versions/doq/bin/doq"
vim.g.pydocstring_formatter = "numpy"

bind('n', '<leader>pl', '<Plug>(pydocstring)', {silent = true})
bind('n', '<leader>pf', ':PydocstringFormat<CR>', {silent = true})

wk.register_keymap(
    'leader', {
        p = {
            name = '+pydocstring',
            l = 'Add docstring to function or class under the cursor',
            f = 'Add docstrings to all functions and classes in the file'
        }
    }
)

