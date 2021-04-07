local utils = require('utils')

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
    },
    prompt_position = 'top',
    sorting_strategy = 'ascending',
  }
}

-- mappings
utils.map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
utils.map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
utils.map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
utils.map('n', '<Leader>fo', '<cmd>Telescope oldfiles<CR>')
