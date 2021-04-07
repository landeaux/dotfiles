local utils = require('utils')

utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')
vim.cmd [[set shortmess+=c]]
vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- Tab completion
function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and utils.t'<C-n>' or utils.t'<Tab>'
end
function _G.smart_shift_tab()
    return vim.fn.pumvisible() == 1 and utils.t'<C-p>' or utils.t'<S-Tab>'
end
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_shift_tab()', { expr = true, noremap = true })
