local utils = require('utils')

-- Some servers have issues with backup files, see https://github.com/neoclide/coc.nvim/issues/649
utils.opt('o', 'backup', false)
utils.opt('o', 'writebackup', false)

vim.cmd [[set shortmess+=c]] -- Don't pass messages to |ins-completion-menu|.
utils.opt('w', 'signcolumn', 'yes')

-- Use <c-space> to trigger completion.
utils.map('i', '<c-d>', 'coc#refresh()', { expr = true })

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
utils.map(
  'i',
  '<cr>',
  'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"',
  { silent = true, expr = true }
)

-- Tab completion
function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and utils.t'<C-n>' or utils.t'<Tab>'
end
function _G.smart_shift_tab()
    return vim.fn.pumvisible() == 1 and utils.t'<C-p>' or utils.t'<S-Tab>'
end
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.smart_shift_tab()', { expr = true, noremap = true })

-- Use `[g` and `]g` to navigate diagnostics
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', {})
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', {})

-- GoTo code navigation.
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

-- Highlight the symbol and its references when holding the cursor.
vim.cmd [[autocmd CursorHold * silent call CocActionAsync('highlight')]]

-- Symbol renaming.
vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(coc-rename)', {})

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})

-- Remap keys for applying codeAction to the current buffer.
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', {})

-- Apply AutoFix to problem on the current line.
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', {})

-- Remap <C-f> and <C-b> for scroll float windows/popups.
utils.map(
  'n',
  '<C-f>',
  'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-f>"',
  { silent = true, nowait = true, expr = true }
)
utils.map(
  'n',
  '<C-b>',
  'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"',
  { silent = true, nowait = true, expr = true }
)
utils.map(
  'i',
  '<C-f>',
  'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<Right>"',
  { silent = true, nowait = true, expr = true }
)
utils.map(
  'i',
  '<C-b>',
  'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<Left>"',
  { silent = true, nowait = true, expr = true }
)
utils.map(
  'v',
  '<C-f>',
  'coc#float#has_scroll() ? coc#float#scroll(1) : "\\<C-f>"',
  { silent = true, nowait = true, expr = true }
)
utils.map(
  'v',
  '<C-b>',
  'coc#float#has_scroll() ? coc#float#scroll(0) : "\\<C-b>"',
  { silent = true, nowait = true, expr = true }
)

-- Add `:Fold` command to fold current buffer.
vim.api.nvim_command('command! -nargs=? Fold :call CocAction("fold", <f-args>)')

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_command('command! -nargs=0 OR :call CocAction("runCommand", "editor.action.organizeImport")')

-- Show diagnostics list
utils.map('n', '<leader>d', ':<C-u>CocList diagnostics<cr>', { silent = true, nowait = true })

-- Manage extensions
utils.map('n', '<leader>e', ':<C-u>CocList extensions<cr>', { silent = true, nowait = true })

-- Show commands
utils.map('n', '<leader>x',  ':<C-u>CocList commands<cr>', { silent = true, nowait = true })

-- Find symbol of current document
utils.map('n', '<leader>o',  ':<C-u>CocList outline<cr>', { silent = true, nowait = true })

-- Search workspace symbols
utils.map('n', '<leader>s',  ':<C-u>CocList -I symbols<cr>', { silent = true, nowait = true })

-- Do default action for next item
utils.map('n', '<leader>j',  ':<C-u>CocNext<CR>', { silent = true, nowait = true })

-- Do default action for previous item
utils.map('n', '<leader>k',  ':<C-u>CocPrev<CR>', { silent = true, nowait = true })

-- Resume latest coc list
utils.map('n', '<leader>r',  ':<C-u>CocListResume<CR>', { silent = true, nowait = true })

-- Define global extensions/language servers
vim.g.coc_global_extensions = {
  'coc-python',
  'coc-yaml',
  'coc-json',
  'coc-tsserver',
  'coc-prettier',
  'coc-eslint',
  'coc-vetur',
}
